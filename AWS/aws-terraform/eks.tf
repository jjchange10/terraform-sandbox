# Managed Node に ssh 用の鍵を生成
module "key_pair" {
  source  = "terraform-aws-modules/key-pair/aws"
  version = "~> 2.0"

  key_name_prefix    = var.name_prefix
  create_private_key = true

  tags = local.tags
}

# VPC の CIDR から ssh を許可する firewall ルールを定義
resource "aws_security_group" "remote_access" {
  name_prefix = "${var.name_prefix}-remote-access"
  description = "Allow remote SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.tags, { Name = "${var.name_prefix}-remote" })
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

#クラスタの設定
  #クラスタ作成
  create = true
  #EKSクラスタ名
  cluster_name                   = var.name_prefix
  #EKSクラスタバージョン
  cluster_version                = var.eks_version
  #EKSクラスタIPアドレスファミリー
  cluster_ip_family              = "ipv4"
  #VPC ID
  vpc_id                         = module.vpc.vpc_id
  #サブネットID
  subnet_ids                     = concat(module.vpc.private_subnets, module.vpc.public_subnets)
  #コントロールプレーンサブネットID
  control_plane_subnet_ids       = module.vpc.intra_subnets
  #クラスタリモートネットワーク設定
  cluster_remote_network_config = {}
  #クラスタサービスIPv4 CIDR
  cluster_service_ipv4_cidr = null
  #クラスタサービスIPv6 CIDR
  cluster_service_ipv6_cidr = null
  #クラスタタグ
  cluster_tags = {}
  #クラスタタイムアウト
  cluster_timeouts = {}
  #クラスタアップグレードポリシー
  cluster_upgrade_policy = {}
  #クラスタゾーンシフト設定
  cluster_zonal_shift_config = {}
  #自動モードカスタムタグ有効化
  enable_auto_mode_custom_tags = true
  #プレフィックスセパレータ
  prefix_separator = "-"


#クラスタ暗号化設定（secretsリソースなどをetcdに格納する際に暗号化するかどうか）→暗号化が不要であればfalseにする
  #https://gavin-zhou.medium.com/%E6%9C%AC%E7%95%AA%E7%92%B0%E5%A2%83%E3%81%AB%E9%81%A9%E3%81%97%E3%81%9Feks%E3%82%AF%E3%83%A9%E3%82%B9%E3%82%BF%E3%81%AE%E8%A8%AD%E8%A8%88%E3%81%A8%E3%83%97%E3%83%AD%E3%83%93%E3%82%B8%E3%83%A7%E3%83%8B%E3%83%B3%E3%82%B0%E6%96%B9%E6%B3%95-%E5%BE%8C%E5%8D%8A-59cd7ca01b08
  #暗号化ポリシー（KMSキーなどを利用する）をクラスターにアタッチ（関連付け）するかどうかを指定。
  attach_cluster_encryption_policy = true
  #どのリソースを暗号化するかを指定する設定。
  cluster_encryption_config      = {}
  #cluster_encryption_config = { "resources": [ "secrets" ] }
  #ポリシーの説明文。何のためのポリシーか、わかりやすく記述するため。
  cluster_encryption_policy_description = "Cluster encryption policy to allow cluster role to utilize CMK provided"
  #ポリシーに名前をつける場合に使う。
  cluster_encryption_policy_name = null
  #IAMポリシーのパス（管理上の名前空間のようなもの）。
  cluster_encryption_policy_path = null
  #ポリシーにタグ（管理用メタデータ）を付けるための設定。
  cluster_encryption_policy_tags = {}


  
# EKS addon をこちらで install
  # 利用可能な addon 一覧はこのコマンドから確認することができる
  # $ aws eks describe-addon-versions  \
  # --query 'sort_by(addons &owner)[].{publisher: publisher, owner: owner, addonName: addonName, type: type}' \
  # --output table
  #自己管理アドオン有効化（クラスタ構築後にユーザ自身でaddonsをインストールするか）→EKSで勝手にインストールして欲しいのでnullにする（false）
  bootstrap_self_managed_addons = null
  #addonsをインストール、更新、削除するためのタイムアウト
  cluster_addons_timeouts = {}
  cluster_addons = {
  #CoreDNS
    coredns = {
      most_recent = true
    }
  #KubeProxy
    kube-proxy = {
      most_recent = true
    }
  #EKS Pod Identity Agent
    eks-pod-identity-agent = {
      most_recent = true
    }
  #AWS EBS CSI Driver
    aws-ebs-csi-driver = {
      most_recent = true
    }
    vpc-cni = {
      most_recent    = true
      before_compute = true
      configuration_values = jsonencode({
        env = {
          // must enable this if pod is running in private subnet and access going out via nat gateway
          AWS_VPC_K8S_CNI_EXTERNALSNAT = "true"

          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
        }
      })
    }
  }

#タグ
  tags = local.tags

#kmsを使用するかどうかを制御します。
  #KMSキー作成(クラスタ暗号化用のKMSキーを作成するかどうかを制御します。)
  #KMSキー作成(クラスタ暗号化用のKMSキーを作成するかどうかを制御します。)
  create_kms_key                 = false
  #create_kms_key = trueの場合独自のKMSキーを作成する
  #KMSキーもRotationが必要な場合　必須というわけではないがローテーションしないとセキュリティリスクが高まる
  enable_kms_key_rotation = true
  #KMSキーを作成する際のオプション
  #KMSキー管理者
  kms_key_administrators = []
  #KMSキー別名
  kms_key_aliases = []
  #KMSキー削除ウィンドウ
  kms_key_deletion_window_in_days = null
  #KMSキー説明
  kms_key_description = null
  #KMSキーデフォルトポリシー有効化
  kms_key_enable_default_policy = true
  #KMSキーオーバーライドポリシー文書
  kms_key_override_policy_documents = []
  #KMSキー所有者
  kms_key_owners = []
  #KMSキーサービスユーザー
  kms_key_service_users = []
  #KMSキーソースポリシー文書
  kms_key_source_policy_documents = []
  #KMSキーユーザー
  kms_key_users = []

#OIDCプロバイダー
  #enable_irsa = trueの場合OIDCプロバイダーを作成する
  #IRSA有効化(IRSAを有効にするためにEKS用のOpenID Connect Providerを作成するかどうかを決定します。)
  #IRSA（IAM Roles for Service Accounts）**は、KubernetesのPodがAWSのリソースにアクセスするために、IAMロールをサービスアカウントに割り当てる仕組みです。
  #IRSAを使うには、EKSクラスターとIAMロールを結びつけるために、OpenID Connect（OIDC）プロバイダーをAWSに作成する必要があります。
  enable_irsa                    = true
  #OIDC証明書のフィンガープリント。EKS クラスターでカスタムの OIDC プロバイダーを使いたい場合
  custom_oidc_thumbprints = []
  #OIDC証明書ルートCA拇印有効化
  include_oidc_root_ca_thumbprint = true
  #OIDC接続オーディエンス。sts.amazonaws.com がデフォルトで使われます。
  openid_connect_audiences = []
  
  
# クラスターアクセスエントリ
  # 現在の caller identity を管理者として追加
  #クラスター作成者管理者権限有効化
  enable_cluster_creator_admin_permissions = true
  #クラスターアクセスエントリ(クラスタにアクセスできる、ユーザやIAMロール、OIDCプロバイダーを指定する)
  #クラスタエンドポイントプライベートアクセス
  cluster_endpoint_private_access = true
  #クラスタエンドポイント公開アクセス(どこからアクセス可能とするか)
  cluster_endpoint_public_access_cidrs = [ "0.0.0.0/0" ]
  #EKSクラスタエンドポイント公開
  #cluster_endpoint_public_access = false(デフォルト)
  cluster_endpoint_public_access = true
  #認証モード
  authentication_mode = "API_AND_CONFIG_MAP" 
  access_entries = {}
  # 他に EKS にアクセスできる IAM Role/User はこちらで付与することも可能
  # access_entries = {
  #   default = {
  #     kubernetes_groups = []
  #     principal_arn     = "FILL_THIS_PRINCIPAL_ARN"

  #     policy_associations = {
  #       default = {
  #         policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  #         access_scope = {
  #           type = "cluster"
  #         }
  #       }
  #     }
  #   },
  # }
  
  
#クラスタのログ
  #クラスタ有効ログタイプ(api, audit, authenticator, controllerManager, schedulerなどがある)。細かく何があるかは調べる
  cluster_enabled_log_types = ["api", "audit", "authenticator"]  
  #クラスタCloudWatchロググループ作成
  create_cloudwatch_log_group = true
  #CloudWatchロググループクラス（STANDARD or INFREQUENT_ACCESS）
  cloudwatch_log_group_class = null
  #CloudWatchロググループKMSキーID
  cloudwatch_log_group_kms_key_id = null
  #CloudWatchロググループ保持期間
  cloudwatch_log_group_retention_in_days = 90
  #CloudWatchロググループタグ
  cloudwatch_log_group_tags = {}


#セキュリティグループ
  #クラスタプライマリセキュリティグループタグ作成
  create_cluster_primary_security_group_tags = true
  #クラスタセキュリティグループ作成
  create_cluster_security_group = true
  cluster_additional_security_group_ids = []
  #クラスタセキュリティグループ追加ルール
  cluster_security_group_additional_rules = {}
  #クラスタセキュリティグループ説明
  cluster_security_group_description = "EKS cluster security group"
  #クラスタセキュリティグループID
  cluster_security_group_id = ""
  #クラスタセキュリティグループ名
  cluster_security_group_name = null
  #クラスタセキュリティグループタグ
  cluster_security_group_tags = {}
  #クラスタセキュリティグループ名前付け
  cluster_security_group_use_name_prefix = true

  #ノードセキュリティグループ作成
  create_node_security_group = true
  #ノードセキュリティグループ追加ルール
  node_security_group_additional_rules = {}
  #ノードセキュリティグループ説明
  node_security_group_description = "EKS node security group"
  #ノードセキュリティグループ有効化
  node_security_group_enable_recommended_rules = true
  #ノードセキュリティグループID
  node_security_group_id = ""
  #ノードセキュリティグループ名
  node_security_group_name = null
  #ノードセキュリティグループタグ
  node_security_group_tags = {}
  #ノードセキュリティグループ名前付け
  node_security_group_use_name_prefix = true

  #ポッドごとにセキュリティグループ有効化できる(vpc-cniで詳細を設定)
  enable_security_groups_for_pods = true



#コンピュートリソース
  #Amazon EKS クラスターの コンピュートリソース（主に EC2 ノードグループ）の設定を管理するためのオプション
  #手動で管理するノードグループの詳細設定を行う場合に使用され、self_managed_node_groups と似た使い方をしますが、EKS による自動管理を避けて自分でノードグループを完全に制御したい場合
  cluster_compute_config = {}

  #EKS による自動管理が可能で、簡素で標準的なノードグループの運用ができるため、管理負担を減らしたい場合
  # x86_64 の manged node group を利用する例となりますが、
  # その以外に、AL2_ARM_64 や Fargate なども利用が可能
  #デフォルトのマネージドノードグループ設定
  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"
    # 利用可能なインスタンスタイプはこちらのページから確認することができます https://console.aws.amazon.com/ec2/home?#InstanceTypes:v=3;instanceFamily=t3,t3a;defaultVCPus=%3C%5C=2
    # vpc-cniが有効になっているため、各インスタンスタイプで利用可能なIPアドレスの数を確認する必要があります
    instance_types = ["t3a.medium"]
    subnet_ids     = module.vpc.private_subnets
  }

  #マネージドノードグループ設定 
  eks_managed_node_groups = {
    default_node_group = {
      use_custom_launch_template = false
      
      disk_size = 20
      remote_access = {
        ec2_ssh_key               = module.key_pair.key_pair_name
        source_security_group_ids = [aws_security_group.remote_access.id]
      }
    }
  }
  #完全に手動で管理し、最も柔軟なカスタマイズが可能なオプションです。細かい制御や特別な運用要件がある場合
  #自己管理ノードグループデフォルト
  self_managed_node_group_defaults = {}
  #自己管理ノードグループ
  self_managed_node_groups = {}

  #Fargateプロファイルデフォルト
  fargate_profile_defaults = {}
  #Fargateプロファイル
  fargate_profiles = {}

  #EFAサポート有効化。Amazon EKS クラスターやノードグループの構成で Elastic Fabric Adapter（EFA）を使うかどうかを制御する設定
  #EFA は、高性能コンピューティング（HPC）アプリケーション向けのネットワークインターフェースです。
  enable_efa_support = false

  #アウトポスト設定。Amazon EKS クラスターやノードグループを AWS Outposts 上で実行するための設定ブロックです。
  #AWS のハードウェアをオンプレミス（自社データセンターなど）に設置して、クラウドと同じ API・サービスを使えるようにするソリューションです。
  outpost_config = {}

#クラスタIDプロバイダー（どのIDプロバイダーを使用するか、IAMなのかOIDCなのか）
  cluster_identity_providers = {}
#IAMロール
  #IAMロール作成
  create_iam_role = true
  #IAMロール追加ポリシー
  iam_role_additional_policies = {}
  #IAMロールARN
  iam_role_arn = null
  #IAMロール説明
  iam_role_description = null
  #IAMロール名
  iam_role_name = null
  #IAMロールパス
  iam_role_path = null
  #IAMロールポリシー境界
  iam_role_permissions_boundary = null
  #IAMロールタグ
  iam_role_tags = {}
  #IAMロール名前付け
  iam_role_use_name_prefix = true
  #ノードIAMロール作成
  create_node_iam_role = true
  #ノードIAMロール追加ポリシー
  node_iam_role_additional_policies = {}
  #ノードIAMロール説明
  node_iam_role_description = null
  #ノードIAMロール名
  node_iam_role_name = null
  #ノードIAMロールパス
  node_iam_role_path = null
  #ノードIAMロールポリシー境界
  node_iam_role_permissions_boundary = null
  #ノードIAMロールタグ
  node_iam_role_tags = {}
  #ノードIAMロール名前付け
  node_iam_role_use_name_prefix = true
  #IPv6 を使う EKS クラスターを構築する場合は true にします。
  #CNI IPv6 IAMポリシー作成
  create_cni_ipv6_iam_policy = false

  

  }