module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.11.0"

  identifier = null

  # 基本設定
  #RDSインスタンスのエンジン
  engine               = null
  #RDSインスタンスのエンジンライフサイクルサポート
  engine_lifecycle_support = null
  #RDSインスタンスのエンジンバージョン
  engine_version       = null
  #RDSインスタンスのファミリー
  family               = null
  #RDSインスタンスのメジャーエンジンバージョン
  major_engine_version = null
  #RDSインスタンスのインスタンスクラス
  instance_class       = null
  #RDSインスタンスの割り当てストレージ
  allocated_storage    = null
  #RDSインスタンスの最大割り当てストレージ
  max_allocated_storage = null
  #RDSインスタンスのストレージタイプ
  storage_type         = "gp2"
  #RDSインスタンスのストレージ暗号化
  storage_encrypted    = true
  #RDSインスタンスのストレージスループット
  storage_throughput   = null
  #RDSインスタンスのKMSキーID
  kms_key_id           = null
  #RDSインスタンスの可用性ゾーン
  availability_zone = null
  #RDSインスタンスの作成
  create_db_instance = true
  #RDSインスタンスのオプショングループの作成
  create_db_option_group = true
  #RDSインスタンスのパラメータグループの作成
  create_db_parameter_group = true
  #RDSインスタンスのサブネットグループの作成
  create_db_subnet_group = false
  #RDSインスタンスのIAMインスタンスプロファイル
  custom_iam_instance_profile = null
  #RDSインスタンスのデータベースインサイトモード
  database_insights_mode = null
  #RDSインスタンスのデータベースインスタンスロールアソシエーション
  db_instance_role_associations = {}
  #RDSインスタンスのタグ
  db_instance_tags = {}
  #RDSインスタンスのオプショングループのタグ
  db_option_group_tags = {}
  #RDSインスタンスのパラメータグループのタグ
  db_parameter_group_tags = {}
  #RDSインスタンスのサブネットグループの説明
  db_subnet_group_description = null
  #RDSインスタンスのサブネットグループの名前
  db_subnet_group_name = null
  #RDSインスタンスのサブネットグループのタグ
  db_subnet_group_tags = {}
  #RDSインスタンスのサブネットグループの使用名前プレフィックス
  db_subnet_group_use_name_prefix = true
  #RDSインスタンスの専用ログボリューム
  dedicated_log_volume = false
  #RDSインスタンスの最終スナップショットの識別子プレフィックス
  final_snapshot_identifier_prefix = "final"
  #RDSインスタンスのインスタンスの使用識別子プレフィックス
  instance_use_identifier_prefix = false
  #RDSインスタンスのIOPS
  iops = null
  #RDSインスタンスのライセンスモデル
  license_model = null
  #RDSインスタンスのマスターユーザーのパスワードの管理
  manage_master_user_password = true
  #RDSインスタンスのマスターユーザーのパスワードの自動回転
  manage_master_user_password_rotation = false
  #RDSインスタンスのマスターユーザーのパスワードの即時回転
  master_user_password_rotate_immediately = null
  #RDSインスタンスのマスターユーザーのパスワードの自動回転
  master_user_password_rotation_automatically_after_days = null
  #RDSインスタンスのマスターユーザーのパスワードの自動回転
  master_user_password_rotation_duration = null
  #RDSインスタンスのマスターユーザーのパスワードの自動回転
  master_user_password_rotation_schedule_expression = null
  #RDSインスタンスのマスターユーザーのシークレットのKMSキーID
  master_user_secret_kms_key_id = null
  #RDSインスタンスのNCHAR文字セット名
  nchar_character_set_name = null
  #RDSインスタンスのネットワークタイプ
  network_type = null
  #RDSインスタンスのオプショングループの説明
  option_group_description = null
  #RDSインスタンスのオプショングループの名前
  option_group_name = null
  #RDSインスタンスのオプショングループの破棄をスキップ
  option_group_skip_destroy = null
  #RDSインスタンスのオプショングループのタイムアウト
  option_group_timeouts = {}
  #RDSインスタンスのオプショングループの使用名前プレフィックス
  option_group_use_name_prefix = true
  #RDSインスタンスの復元ポイントインタイム
  restore_to_point_in_time = null
  #RDSインスタンスのS3インポート
  s3_import = null
  #RDSインスタンスのストレージのアップグレード設定
  upgrade_storage_config = null

  # DB アクセス設定
  #RDSインスタンスのデータベース名
  db_name  = null
  #RDSインスタンスのユーザー名
  username = null
  #RDSインスタンスのパスワード
  password = null
  #RDSインスタンスのポート
  port     = null
  
  # 可用性設定
  #RDSインスタンスのマルチAZ
  multi_az              = false
  #RDSインスタンスのサブネットID
  subnet_ids            = []
  #RDSインスタンスのVPCセキュリティグループID
  vpc_security_group_ids = []
  
  # メンテナンス設定
  #RDSインスタンスのメンテナンスウィンドウ
  maintenance_window      = null
  #RDSインスタンスのバックアップウィンドウ
  backup_window           = null
  #RDSインスタンスのバックアップ保有期間
  backup_retention_period = null
  #RDSインスタンスのブループルーグアップデート
  blue_green_update = {}
  
  # タグ設定
  tags                   = {}
  
  # ログ設定
  #RDSインスタンスの有効化されたクラウドウォッチログエクスポート
  enabled_cloudwatch_logs_exports        = []
  #RDSインスタンスのクラウドウォッチロググループの作成
  create_cloudwatch_log_group            = false
  #RDSインスタンスのクラウドウォッチロググループのクラス
  cloudwatch_log_group_class = null
  #RDSインスタンスのクラウドウォッチロググループの保持期間
  cloudwatch_log_group_retention_in_days = 7
  #RDSインスタンスのクラウドウォッチロググループのKMSキーID
  cloudwatch_log_group_kms_key_id        = null
  #RDSインスタンスのクラウドウォッチロググループの破棄をスキップ
  cloudwatch_log_group_skip_destroy = null
  #RDSインスタンスのクラウドウォッチロググループのタグ
  cloudwatch_log_group_tags = {}
  
  # 削除保護設定
  #RDSインスタンスの削除保護
  deletion_protection      = false
  #RDSインスタンスの自動バックアップの削除
  delete_automated_backups = true
  #RDSインスタンスの最終スナップショットのスキップ
  skip_final_snapshot      = false
  
  # パフォーマンス設定
  #RDSインスタンスのパフォーマンスインサイトの有効化
  performance_insights_enabled           = false
  #RDSインスタンスのパフォーマンスインサイトの保持期間
  performance_insights_retention_period  = 7
  #RDSインスタンスのパフォーマンスインサイトのKMSキーID
  performance_insights_kms_key_id        = null
  
  # レプリケーション設定
  #RDSインスタンスのレプリケーションソースデータベース
  replicate_source_db = null
  #RDSインスタンスのレプリケーションモード
  replica_mode        = null
  
  # パラメータとオプション
  #RDSインスタンスのパラメータ
  parameters = []
  #RDSインスタンスのオプション
  options    = []
  #RDSインスタンスのパラメータグループの説明
  parameter_group_description = null
  #RDSインスタンスのパラメータグループの破棄をスキップ
  parameter_group_skip_destroy = null
  #RDSインスタンスのパラメータグループの名前
  parameter_group_name = null
  #RDSインスタンスのパラメータグループの使用名前プレフィックス
  parameter_group_use_name_prefix = true
  
  # ドメイン設定
  #RDSインスタンスのドメイン
  domain                = null
  #RDSインスタンスのドメインIAMロール名
  domain_iam_role_name  = null
  #RDSインスタンスのドメインOU
  domain_ou = null
  #RDSインスタンスのドメイン認証シークレットARN
  domain_auth_secret_arn = null
  #RDSインスタンスのドメインDNS IP
  domain_dns_ips = null
  #RDSインスタンスのドメインFQDN
  domain_fqdn = null

  
  # 文字セットとタイムゾーン
  #RDSインスタンスの文字セット名
  character_set_name = null
  #RDSインスタンスのタイムゾーン
  timezone           = null
  
  # モニタリング設定
  #RDSインスタンスのモニタリングロールの作成
  create_monitoring_role        = false
  #RDSインスタンスのモニタリング間隔
  monitoring_interval           = 0
  #RDSインスタンスのモニタリングロールのARN
  monitoring_role_arn           = null
  #RDSインスタンスのモニタリングロールの名前
  monitoring_role_name          = null
  #RDSインスタンスのモニタリングロールの使用名前プレフィックス
  monitoring_role_use_name_prefix = true
  #RDSインスタンスのモニタリングロールの説明
  monitoring_role_description   = null
  #RDSインスタンスのモニタリングロールのパーミッション境界
  monitoring_role_permissions_boundary = null
  
  # アップグレード設定
  #RDSインスタンスのメジャーバージョンのアップグレードを許可
  allow_major_version_upgrade = false
  #RDSインスタンスのマイナーバージョンの自動アップグレード
  auto_minor_version_upgrade  = true
  #RDSインスタンスの即時適用
  apply_immediately           = false
  #RDSインスタンスのCA証明書の識別子
  ca_cert_identifier = null
  
  # スナップショット設定
  #RDSインスタンスのスナップショットの識別子
  snapshot_identifier   = null
  #RDSインスタンスのスナップショットのタグ付け
  copy_tags_to_snapshot = false
  #RDSインスタンスのパブリックアクセス
  publicly_accessible = false
  
  iam_database_authentication_enabled = false
  
  putin_khuylo = true
}