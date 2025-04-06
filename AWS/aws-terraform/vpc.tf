# 共通で使う変数の設定
locals {
  azs = slice(data.aws_availability_zones.available.names, 0, 3)

  tags = {
    project    = var.name_prefix
    managed_by = "Terraform"
  }
}

# data を利用して現在のリージョンから使える aws availability zones を取得します。
# この手法を使えば様々なリソースを Dynamic に生成できます。
# 他によく使われている例としてたとえば、Amazon Linux や Ubuntu の AMI の取得が挙がられます。
data "aws_availability_zones" "available" {}

# VPC 関連のリソースを構築
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  #VPC名
  name                  = var.name_prefix
  #VPC CIDR
  cidr                  = var.vpc_cidr
  #セカンダリCIDRブロック
  secondary_cidr_blocks = var.secondary_cidr_blocks
  #AZ
  azs = local.azs
  #プライベートサブネット
  private_subnets = [for k, v in local.azs : cidrsubnet(var.vpc_cidr, 2, k)]
  #パブリックサブネット
  public_subnets  = [for k, v in local.azs : cidrsubnet(var.secondary_cidr_blocks.0, 2, k)]
  #イントラサブネット
  intra_subnets   = [for k, v in local.azs : cidrsubnet(var.secondary_cidr_blocks.1, 2, k)]

  #パブリックサブネットのパブリックIPを自動で割り当てる
  map_public_ip_on_launch = true
  #NATゲートウェイを作成
  enable_nat_gateway      = true
  #NATゲートウェイを1つだけ作成
  single_nat_gateway      = true
  #Egress Onlyインターネットゲートウェイを作成
  create_egress_only_igw  = true
  
  public_subnet_tags = {
    #サブネットタイプ
    "subnet-type"            = "public"
    #ELB用のタグ
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    #サブネットタイプ
    "subnet-type"                     = "private"
    #内向きELB用のタグ
    "kubernetes.io/role/internal-elb" = 1
  }

  tags = local.tags

  #Amazon ASN 
  amazon_side_asn = "64512"
  #azs = []
  #cidr_block = "10.0.0.0/16"
  #データベースインターネットゲートウェイルートを作成
  create_database_internet_gateway_route = false
  #データベースNATゲートウェイルートを作成
  create_database_nat_gateway_route = false
  #データベースサブネットグループを作成
  create_database_subnet_group = true
  #データベースサブネットルートテーブルを作成
  create_database_subnet_route_table = false
  #Egress Onlyインターネットゲートウェイを作成
  #create_egress_only_igw = true
  #Elasticacheサブネットグループを作成
  create_elasticache_subnet_group = true
  #Elasticacheサブネットルートテーブルを作成
  create_elasticache_subnet_route_table = false
  #フローログCloudWatch IAMロールを作成
  create_flow_log_cloudwatch_iam_role = false
  #フローログCloudWatchロググループを作成
  create_flow_log_cloudwatch_log_group = false
  #インターネットゲートウェイを作成
  create_igw = true
  #複数のイントラルートテーブルを作成
  create_multiple_intra_route_tables = false
  #複数のパブリックルートテーブルを作成
  create_multiple_public_route_tables = false
  #プライベートNATゲートウェイルートを作成
  create_private_nat_gateway_route = true
  #Redshiftサブネットグループを作成
  create_redshift_subnet_group = true
  #Redshiftサブネットルートテーブルを作成
  create_redshift_subnet_route_table = false
  #VPCを作成
  create_vpc = true
  #顧客ゲートウェイタグ
  customer_gateway_tags = {}
  #顧客所有IPv4プール
  customer_owned_ipv4_pool = null
  #データベースACLタグ
  database_acl_tags = {}
  #データベース専用ネットワークACLを作成
  database_dedicated_network_acl = false
  #データベースインバウンドACLルール
  database_inbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #データベースアウトバウンドACLルール
  database_outbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #データベースルートテーブルタグ
  database_route_table_tags = {}
  #データベースサブネットのIPv6アドレスを作成
  database_subnet_assign_ipv6_address_on_creation = false
  #データベースサブネットのDNS64を有効化
  database_subnet_enable_dns64 = true
  #データベースサブネットのDNS Aレコードを有効化
  database_subnet_enable_resource_name_dns_a_record_on_launch = false
  #データベースサブネットのDNS AAAAレコードを有効化
  database_subnet_enable_resource_name_dns_aaaa_record_on_launch = true
  #データベースサブネットグループ名
  database_subnet_group_name = null
  #データベースサブネットグループタグ
  database_subnet_group_tags = {}
  #データベースサブネットのIPv6ネイティブを有効化
  database_subnet_ipv6_native = false
  #データベースサブネットのIPv6プレフィックス
  database_subnet_ipv6_prefixes = []
  #データベースサブネット名
  database_subnet_names =[]
  #データベースサブネットのプライベートDNSホスト名タイプを有効化
  database_subnet_private_dns_hostname_type_on_launch = null
  #データベースサブネットのサフィックス
  database_subnet_suffix = "db"
  #データベースサブネットタグ
  database_subnet_tags = {}
  #データベースサブネット
  database_subnets = []
  #デフォルトネットワークACLのアウトバウンドルール
  default_network_acl_egress = [ { "action": "allow", "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_no": 100, "to_port": 0 }, { "action": "allow", "from_port": 0, "ipv6_cidr_block": "::/0", "protocol": "-1", "rule_no": 101, "to_port": 0 } ]
  #デフォルトネットワークACLのインバウンドルール
  default_network_acl_ingress = [ { "action": "allow", "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_no": 100, "to_port": 0 }, { "action": "allow", "from_port": 0, "ipv6_cidr_block": "::/0", "protocol": "-1", "rule_no": 101, "to_port": 0 } ]
  #デフォルトネットワークACLの名前
  default_network_acl_name = null
  #デフォルトネットワークACLのタグ
  default_network_acl_tags = {}
  #デフォルトルートテーブルの名前
  default_route_table_name = null
  #デフォルトルートテーブルの伝播VPCゲートウェイ
  default_route_table_propagating_vgws = []
  #デフォルトルートテーブルのルート
  default_route_table_routes = []
  #デフォルトルートテーブルのタグ
  default_route_table_tags = {}
  #デフォルトセキュリティグループのアウトバウンドルール
  default_security_group_egress = []
  #デフォルトセキュリティグループのインバウンドルール
  default_security_group_ingress = []
  #デフォルトセキュリティグループの名前
  default_security_group_name = null
  #デフォルトセキュリティグループのタグ
  default_security_group_tags = {}
  #デフォルトVPCのDNSホスト名を有効化
  default_vpc_enable_dns_hostnames = true
  #デフォルトVPCのDNSサポートを有効化
  default_vpc_enable_dns_support = true
  #デフォルトVPCの名前
  default_vpc_name = null
  #デフォルトVPCのタグ
  default_vpc_tags = {}
  #DHCPオプションのドメイン名
  dhcp_options_domain_name = ""
  #DHCPオプションのドメイン名サーバー
  dhcp_options_domain_name_servers = [ "AmazonProvidedDNS" ]
  #DHCPオプションのIPv6アドレスの優先借用期間
  dhcp_options_ipv6_address_preferred_lease_time = null
  #DHCPオプションのNetBIOS名サーバー
  dhcp_options_netbios_name_servers = []
  #DHCPオプションのNetBIOSノードタイプ
  dhcp_options_netbios_node_type = ""
  #DHCPオプションのNTPサーバー
  dhcp_options_ntp_servers = []
  #DHCPオプションのタグ
  dhcp_options_tags = {}
  #ElasticacheサブネットグループのACLタグ
  elasticache_acl_tags = {}
  #Elasticacheサブネットグループの専用ネットワークACLを作成
  elasticache_dedicated_network_acl = false
  #ElasticacheサブネットグループのインバウンドACLルール
  elasticache_inbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #ElasticacheサブネットグループのアウトバウンドACLルール
  elasticache_outbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #Elasticacheサブネットグループのルートテーブルタグ
  elasticache_route_table_tags = {}
  #ElasticacheサブネットのIPv6アドレスを作成
  elasticache_subnet_assign_ipv6_address_on_creation = false
  #ElasticacheサブネットのDNS64を有効化
  elasticache_subnet_enable_dns64 = true
  #ElasticacheサブネットのDNS Aレコードを有効化
  elasticache_subnet_enable_resource_name_dns_a_record_on_launch = false
  #Elasticacheサブネットグループの名前
  elasticache_subnet_group_name = null
  #Elasticacheサブネットグループのタグ
  elasticache_subnet_group_tags = {}
  #ElasticacheサブネットのIPv6ネイティブを有効化
  elasticache_subnet_ipv6_native = false
  #ElasticacheサブネットのIPv6プレフィックス
  elasticache_subnet_ipv6_prefixes = []
  #Elasticacheサブネット名
  elasticache_subnet_names = []
  #ElasticacheサブネットのプライベートDNSホスト名タイプを有効化
  elasticache_subnet_private_dns_hostname_type_on_launch = null
  #Elasticacheサブネットのサフィックス
  elasticache_subnet_suffix = "elasticache"
  #Elasticacheサブネットタグ
  elasticache_subnet_tags = {}
  #Elasticacheサブネット
  elasticache_subnets = []
  #DHCPオプションを有効化
  enable_dhcp_options = false
  #DNSホスト名を有効化
  enable_dns_hostnames = true
  #DNSサポートを有効化
  enable_dns_support = true
  #フローログを有効化
  enable_flow_log = false
  #IPv6を有効化
  enable_ipv6 = false
  #NATゲートウェイを有効化
  #enable_nat_gateway = false
  #ネットワークアドレス使用率メトリクスを有効化
  enable_network_address_usage_metrics = null
  #パブリックRedshiftを有効化
  enable_public_redshift = false
  #VPNゲートウェイを有効化
  enable_vpn_gateway = false
  #外部NAT IP ID
  external_nat_ip_ids = []
  #外部NAT IP
  external_nat_ips = []
  #フローログCloudWatch IAMロールのARN
  flow_log_cloudwatch_iam_role_arn = ""
  #フローログCloudWatch IAMロールの条件
  flow_log_cloudwatch_iam_role_conditions = []
  #フローログCloudWatchロググループのクラス
  flow_log_cloudwatch_log_group_class = null
  #フローログCloudWatchロググループのKMSキーID
  flow_log_cloudwatch_log_group_kms_key_id = null
  #フローログCloudWatchロググループの名前プレフィックス
  flow_log_cloudwatch_log_group_name_prefix = "/aws/vpc-flow-log/"
  #フローログCloudWatchロググループの名前サフィックス
  flow_log_cloudwatch_log_group_name_suffix = ""
  #フローログCloudWatchロググループの保持期間
  flow_log_cloudwatch_log_group_retention_in_days = null
  #フローログCloudWatchロググループの破棄を防止
  flow_log_cloudwatch_log_group_skip_destroy = false
  #フローログCloudWatchロググループの送信先
  flow_log_deliver_cross_account_role = null
  #フローログの送信先ARN
  flow_log_destination_arn = ""
  #フローログの送信先タイプ
  flow_log_destination_type = "cloud-watch-logs"
  #フローログのログ形式
  flow_log_log_format = null
  #フローログのハイブ互換パーティションを有効化
  flow_log_hive_compatible_partitions = false
  #フローログの最大集計間隔
  flow_log_max_aggregation_interval = 600
  #フローログの時間ごとのパーティションを有効化
  flow_log_per_hour_partition = false
  #フローログのトラフィックタイプ
  flow_log_traffic_type = "ALL"   
  #インターネットゲートウェイのタグ
  igw_tags = {}
  #インスタンスタニティ
  instance_tenancy = "default"
  #イントラサブネットのタグ
  intra_subnet_tags = {}
  #イントラサブネットの専用ネットワークACLを作成
  intra_dedicated_network_acl = false
  #イントラサブネットのインバウンドACLルール
  intra_inbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #イントラサブネットのアウトバウンドACLルール
  intra_outbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #イントラサブネットのルートテーブルタグ
  intra_route_table_tags = {}
  #イントラサブネットのIPv6アドレスを作成
  intra_subnet_assign_ipv6_address_on_creation = false
  #イントラサブネットのDNS64を有効化
  intra_subnet_enable_resource_name_dns_a_record_on_launch = false
  #イントラサブネットのDNS AAAAレコードを有効化
  intra_subnet_enable_resource_name_dns_aaaa_record_on_launch = true
  #イントラサブネットのIPv6ネイティブを有効化
  intra_subnet_ipv6_native = false
  #イントラサブネットのIPv6プレフィックス
  intra_subnet_ipv6_prefixes = []
  #イントラサブネット名
  intra_subnet_names = []
  #イントラサブネットのプライベートDNSホスト名タイプを有効化
  intra_subnet_private_dns_hostname_type_on_launch = null
  #イントラサブネットのサフィックス
  intra_subnet_suffix = "intra"
  #イントラサブネットのタグ
  #intra_subnet_tags = {}
  #intra_subnets = []
  #IPv4 IPAMプールID
  ipv4_ipam_pool_id = null
  #IPv4 IPAMプールのネットマスク長
  ipv4_netmask_length = null
  #IPv6 CIDR
  ipv6_cidr = null
  #IPv6 CIDRブロックネットワークボーダーグループ
  ipv6_cidr_block_network_border_group = {}
  #IPv6 IPAMプールID
  ipv6_ipam_pool_id = null
  #IPv6 IPAMプールのネットマスク長
  ipv6_netmask_length = null
  #デフォルトネットワークACLを管理
  manage_default_network_acl = true
  #デフォルトルートテーブルを管理
  manage_default_route_table = true
  #デフォルトセキュリティグループを管理
  manage_default_security_group = true
  #デフォルトVPCを管理
  manage_default_vpc = true
  #IPv4マッピングを有効化
  map_customer_owned_ip_on_launch = false
  #IPv4マッピングを有効化
  #map_public_ip_on_launch = false
  #VPC名
  #name = ""
  #NATゲートウェイのタグ
  nat_eip_tags = {}
  #NATゲートウェイの宛先CIDRブロック
  nat_gateway_destination_cidr_block = "0.0.0.0/0"
  #NATゲートウェイのタグ
  nat_gateway_tags = {}
  #NATゲートウェイごとのAZ
  one_nat_gateway_per_az = false
  #アウトポストのACLタグ
  outpost_acl_tags = {}
  #アウトポストのARN
  outpost_arn = null
  #アウトポストのAZ
  outpost_az = null
  #アウトポストの専用ネットワークACLを作成
  outpost_dedicated_network_acl = false
  #アウトポストのインバウンドACLルール
  outpost_inbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #アウトポストのアウトバウンドACLルール
  outpost_outbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #アウトポストのサブネットのIPv6アドレスを作成
  outpost_subnet_assign_ipv6_address_on_creation = false
  #アウトポストのサブネットのDNS64を有効化
  outpost_subnet_enable_dns64 = true
  #アウトポストのサブネットのDNS Aレコードを有効化
  outpost_subnet_enable_resource_name_dns_a_record_on_launch = false
  #アウトポストのサブネットのDNS AAAAレコードを有効化
  outpost_subnet_enable_resource_name_dns_aaaa_record_on_launch = true
  #アウトポストのサブネットのIPv6ネイティブを有効化
  outpost_subnet_ipv6_native = false
  #アウトポストのサブネットのIPv6プレフィックス
  outpost_subnet_ipv6_prefixes = []
  #アウトポストのサブネット名
  outpost_subnet_names = []
  #アウトポストのサブネットのプライベートDNSホスト名タイプを有効化
  outpost_subnet_private_dns_hostname_type_on_launch = null
  #アウトポストのサブネットのサフィックス
  outpost_subnet_suffix = "outpost"
  #アウトポストのサブネットのタグ
  outpost_subnet_tags = {}
  #アウトポストのサブネット
  outpost_subnets = []
  #プライベートACLのタグ
  private_acl_tags = {}
  #プライベートの専用ネットワークACLを作成
  private_dedicated_network_acl = false
  #プライベートのインバウンドACLルール
  private_inbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #プライベートのアウトバウンドACLルール
  private_outbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #プライベートのルートテーブルタグ
  private_route_table_tags = {}
  #プライベートのサブネットのIPv6アドレスを作成
  private_subnet_assign_ipv6_address_on_creation = false
  #プライベートのサブネットのDNS64を有効化
  private_subnet_enable_dns64 = true
  #プライベートのサブネットのDNS Aレコードを有効化
  private_subnet_enable_resource_name_dns_a_record_on_launch = false
  #プライベートのサブネットのDNS AAAAレコードを有効化
  private_subnet_enable_resource_name_dns_aaaa_record_on_launch = true
  #プライベートのサブネットのIPv6ネイティブを有効化
  private_subnet_ipv6_native = false
  #プライベートのサブネットのIPv6プレフィックス
  private_subnet_ipv6_prefixes = []
  #プライベートのサブネット名
  private_subnet_names = []
  #プライベートのサブネットのプライベートDNSホスト名タイプを有効化
  private_subnet_private_dns_hostname_type_on_launch = null
  #プライベートのサブネットのサフィックス
  private_subnet_suffix = "private"
  #プライベートのサブネットのタグ
  #private_subnet_tags = {}
  #プライベートのサブネット
  #private_subnets = []
  #イントラサブネットのルートテーブルを伝播
  propagate_intra_route_tables_vgw = false
  #プライベートサブネットのルートテーブルを伝播
  propagate_private_route_tables_vgw = false
  #パブリックサブネットのルートテーブルを伝播
  propagate_public_route_tables_vgw = false
  #パブリックACLのタグ
  public_acl_tags = {}
  #パブリックの専用ネットワークACLを作成
  public_dedicated_network_acl = false
  #パブリックのインバウンドACLルール
  public_inbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #パブリックのアウトバウンドACLルール
  public_outbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #パブリックのルートテーブルタグ
  public_route_table_tags = {}
  #パブリックのサブネットのDNS64を有効化
  public_subnet_enable_dns64 = true
  #パブリックのサブネットのDNS Aレコードを有効化
  public_subnet_enable_resource_name_dns_a_record_on_launch = false
  #パブリックのサブネットのDNS AAAAレコードを有効化
  public_subnet_enable_resource_name_dns_aaaa_record_on_launch = true
  #パブリックのサブネットのIPv6ネイティブを有効化
  public_subnet_ipv6_native = false
  #パブリックのサブネットのIPv6プレフィックス
  public_subnet_ipv6_prefixes = []
  #パブリックのサブネット名
  public_subnet_names = []
  #パブリックのサブネットのプライベートDNSホスト名タイプを有効化
  public_subnet_private_dns_hostname_type_on_launch = null
  #パブリックのサブネットのサフィックス
  public_subnet_suffix = "public"
  #パブリックのサブネットのタグ
  #public_subnet_tags = {}
  public_subnet_tags_per_az = {}
  #パブリックのサブネット
  #public_subnets = []
  putin_khuylo = true
  #RedshiftのACLタグ
  redshift_acl_tags = {}
  #Redshiftの専用ネットワークACLを作成
  redshift_dedicated_network_acl = false
  #RedshiftのインバウンドACLルール
  redshift_inbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #RedshiftのアウトバウンドACLルール
  redshift_outbound_acl_rules = [ { "cidr_block": "0.0.0.0/0", "from_port": 0, "protocol": "-1", "rule_action": "allow", "rule_number": 100, "to_port": 0 } ]
  #Redshiftのルートテーブルタグ
  redshift_route_table_tags = {}
  #RedshiftのサブネットのIPv6アドレスを作成
  redshift_subnet_assign_ipv6_address_on_creation = false
  #RedshiftのサブネットのDNS64を有効化
  redshift_subnet_enable_dns64 = true
  #RedshiftのサブネットのDNS Aレコードを有効化
  redshift_subnet_enable_resource_name_dns_a_record_on_launch = false
  #RedshiftのサブネットのDNS AAAAレコードを有効化
  redshift_subnet_enable_resource_name_dns_aaaa_record_on_launch = true
  #Redshiftのサブネットグループ名
  redshift_subnet_group_name = null
  #Redshiftのサブネットグループのタグ
  redshift_subnet_group_tags = {}
  #RedshiftのサブネットのIPv6ネイティブを有効化
  redshift_subnet_ipv6_native = false
  #RedshiftのサブネットのIPv6プレフィックス
  redshift_subnet_ipv6_prefixes = []
  #Redshiftのサブネット名
  redshift_subnet_names = []
  #RedshiftのサブネットのプライベートDNSホスト名タイプを有効化
  redshift_subnet_private_dns_hostname_type_on_launch = null
  #Redshiftのサブネットのサフィックス
  redshift_subnet_suffix = "redshift"
  #Redshiftのサブネットのタグ
  redshift_subnet_tags = {}
  #Redshiftのサブネット
  redshift_subnets = []
  #NAT IPの再利用
  reuse_nat_ips = false
  #secondary_cidr_blocks = []
  #single_nat_gateway = false
  #tags = {}
  use_ipam_pool = false
  #VPCブロックパブリックアクセス除外
  vpc_block_public_access_exclusions = {}
  #VPCブロックパブリックアクセスオプション
  vpc_block_public_access_options = {}
  #VPCフローログIAMポリシー名
  vpc_flow_log_iam_policy_name = "vpc-flow-log-to-cloudwatch"
  #VPCフローログIAMポリシー名前付け
  vpc_flow_log_iam_policy_use_name_prefix = true
  #VPCフローログIAMロール名
  vpc_flow_log_iam_role_name = "vpc-flow-log-role"
  #VPCフローログIAMロール名前付け
  vpc_flow_log_iam_role_use_name_prefix = true
  #VPCフローログIAMロールポリシー境界
  #vpc_flow_log_iam_role_permissions_boundary = null
  #VPCフローログタグ
  vpc_flow_log_tags = {}
  #VPCタグ
  vpc_tags = {}
  #VPNゲートウェイのAZ
  vpn_gateway_az = null
  #VPNゲートウェイのID
  vpn_gateway_id = ""
  #VPNゲートウェイのタグ
  vpn_gateway_tags = {}
}
  
  
  
  
  
 
  

  
  

  


  

