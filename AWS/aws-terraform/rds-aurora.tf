module "rds-aurora" {
  source = "terraform-aws-modules/rds-aurora/aws"
  version = "9.13.0"
  
  #RDS Auroraのストレージの割り当て
  allocated_storage = null
  #RDS Auroraのメジャーバージョンのアップグレードを許可
  allow_major_version_upgrade                 = null
  #RDS Auroraの即時適用
  apply_immediately                           = null
  #RDS Auroraのマイナーバージョンの自動アップグレード
  auto_minor_version_upgrade                  = null
  #RDS Auroraのオートスケーリングの有効化
  autoscaling_enabled                         = false
  #RDS Auroraのオートスケーリングの最大容量
  autoscaling_max_capacity                    = 0
  #RDS Auroraのオートスケーリングの最小容量
  autoscaling_min_capacity                    = 0
  #RDS Auroraのオートスケーリングのポリシー名
  autoscaling_policy_name                     = "target-metric"
  #RDS Auroraのオートスケーリングのスケールインのクールダウン
  autoscaling_scale_in_cooldown               = 300
  #RDS Auroraのオートスケーリングのスケールアウトのクールダウン
  autoscaling_scale_out_cooldown              = 300
  #RDS Auroraのオートスケーリングのターゲット接続数
  autoscaling_target_connections              = 700
  #RDS AuroraのオートスケーリングのターゲットCPU
  autoscaling_target_cpu                      = 70
  #RDS Auroraの可用性ゾーン
  availability_zones                          = null
  #RDS Auroraのバックトラックウィンドウ
  backtrack_window                            = null
  #RDS Auroraのバックアップの保持期間
  backup_retention_period                     = null
  #RDS AuroraのCA証明書の識別子
  ca_cert_identifier                          = null
  #RDS Auroraのクラウドウォッチロググループのクラス
  cloudwatch_log_group_class                  = null
  #RDS AuroraのクラウドウォッチロググループのKMSキーID
  cloudwatch_log_group_kms_key_id             = null
  #RDS Auroraのクラウドウォッチロググループの保持期間
  cloudwatch_log_group_retention_in_days      = 7
  #RDS Auroraのクラウドウォッチロググループの破棄をスキップ
  cloudwatch_log_group_skip_destroy           = null
  #RDS Auroraのクラウドウォッチロググループのタグ
  cloudwatch_log_group_tags                   = {}
  #RDS AuroraのクラスターのCA証明書の識別子
  cluster_ca_cert_identifier                  = null
  #RDS Auroraのクラスターのメンバー
  cluster_members                             = null
  #RDS Auroraのクラスターのモニタリング間隔
  cluster_monitoring_interval                 = 0
  #RDS Auroraのクラスターのパフォーマンスインサイトの有効化
  cluster_performance_insights_enabled = null
  #RDS AuroraのクラスターのパフォーマンスインサイトのKMSキーID
  cluster_performance_insights_kms_key_id = null
  #RDS Auroraのクラスターのパフォーマンスインサイトの保持期間
  cluster_performance_insights_retention_period = null
  #RDS Auroraのクラスターのオートスケーリングのタイプ
  cluster_scalability_type = null
  #RDS Auroraのクラスターのタグ
  cluster_tags = {}
  #RDS Auroraのクラスターのタイムアウト
  cluster_timeouts                            = {}
  #RDS Auroraのクラスターの使用名前プレフィックス
  cluster_use_name_prefix = false
  #RDS Auroraのクラスターの冗長性
  compute_redundancy                          = null
  #RDS Auroraのクラスターのスナップショットのタグ付け
  copy_tags_to_snapshot                       = null
  #RDS Auroraのクラスターの作成
  create                                      = true
  #RDS Auroraのクラウドウォッチロググループの作成
  create_cloudwatch_log_group                 = false
  #RDS Auroraのクラスターのアクティビティストリームの作成
  create_db_cluster_activity_stream           = false
  #RDS Auroraのクラスターパラメータグループの作成 
  create_db_cluster_parameter_group           = false
  #RDS Auroraのパラメータグループの作成
  create_db_parameter_group                   = false
  #RDS Auroraのサブネットグループの作成
  create_db_subnet_group                      = false
  #RDS Auroraのモニタリングロールの作成
  create_monitoring_role                      = true
  #RDS Auroraのセキュリティグループの作成
  create_security_group                       = true
  #RDS Auroraのシャードグループの作成
  create_shard_group                          = false
  #RDS Auroraのデータベースインサイトモード
  database_insights_mode                      = null
  #RDS Auroraのデータベース名
  database_name                               = null
  #RDS AuroraのクラスターのアクティビティストリームのKMSキーID
  db_cluster_activity_stream_kms_key_id       = null
  #RDS Auroraのクラスターのアクティビティストリームのモード
  db_cluster_activity_stream_mode             = null
  #RDS Auroraのクラスターのデータベースインスタンスパラメータグループ名
  db_cluster_db_instance_parameter_group_name = null
  #RDS Auroraのクラスターのデータベースインスタンスクラス
  db_cluster_instance_class                   = null
  #RDS Auroraのクラスターパラメータグループの説明
  db_cluster_parameter_group_description      = null
  #RDS Auroraのクラスターパラメータグループのファミリー
  db_cluster_parameter_group_family           = ""
  #RDS Auroraのクラスターパラメータグループの名前
  db_cluster_parameter_group_name             = null
  #RDS Auroraのクラスターパラメータグループのパラメータ
  db_cluster_parameter_group_parameters       = []
  #RDS Auroraのクラスターパラメータグループの使用名前プレフィックス
  db_cluster_parameter_group_use_name_prefix  = true
  #RDS Auroraのパラメータグループの説明
  db_parameter_group_description              = null
  #RDS Auroraのパラメータグループのファミリー
  db_parameter_group_family                   = ""
  #RDS Auroraのパラメータグループの名前
  db_parameter_group_name                     = null
  #RDS Auroraのパラメータグループのパラメータ
  db_parameter_group_parameters               = []
  #RDS Auroraのパラメータグループの使用名前プレフィックス
  db_parameter_group_use_name_prefix          = true
  #RDS Auroraのシャードグループの識別子
  db_shard_group_identifier                   = null
  #RDS Auroraのサブネットグループの名前
  db_subnet_group_name                        = ""
  #RDS Auroraの自動バックアップの削除
  delete_automated_backups = null
  #RDS Auroraの削除保護
  deletion_protection                         = null
  #RDS Auroraのドメイン
  domain = null
  #RDS AuroraのドメインのIAMロール名
  domain_iam_role_name = null
  #RDS Auroraのグローバルクラスターの書き込み転送の有効化
  enable_global_write_forwarding              = null
  #RDS AuroraのHTTPエンドポイントの有効化
  enable_http_endpoint                        = null
  #RDS Auroraのローカル書き込み転送の有効化
  enable_local_write_forwarding               = null
  #RDS Auroraのクラウドウォッチロググループのエクスポート
  enabled_cloudwatch_logs_exports             = []
  #RDS Auroraのエンドポイント
  endpoints                                   = {}
  #RDS Auroraのエンジン
  engine                                      = null
  #RDS Auroraのエンジンのライフサイクルサポート
  engine_lifecycle_support                    = null
  #RDS Auroraのエンジンモード
  engine_mode                                 = "provisioned"
  #RDS Auroraのエンジンのネイティブ監査フィールドの有効化
  engine_native_audit_fields_included         = false
  #RDS Auroraのエンジンのバージョン
  engine_version                              = null
  #RDS Auroraの最終スナップショットの識別子
  final_snapshot_identifier                   = null
  #RDS Auroraのグローバルクラスターの識別子
  global_cluster_identifier                   = null
  #RDS AuroraのIAMデータベース認証の有効化
  iam_database_authentication_enabled         = null
  #RDS AuroraのIAMロールの説明
  iam_role_description                        = null
  #RDS AuroraのIAMロールの強制的なポリシーのデタッチ
  iam_role_force_detach_policies              = null
  #RDS AuroraのIAMロールのマネージドポリシーのARN
  iam_role_managed_policy_arns                = null
  #RDS AuroraのIAMロールのセッションの最大期間
  iam_role_max_session_duration               = null
  #RDS AuroraのIAMロールの名前
  iam_role_name                               = null
  #RDS AuroraのIAMロールのパス
  iam_role_path                               = null
  #RDS AuroraのIAMロールのポリシー境界
  iam_role_permissions_boundary               = null
  #RDS AuroraのIAMロールの使用名前プレフィックス
  iam_role_use_name_prefix                    = false
  #RDS AuroraのIAMロール
  iam_roles                                   = {}
  #RDS Auroraのインスタンスクラス
  instance_class                              = ""
  #RDS Auroraのインスタンスのタイムアウト
  instance_timeouts                           = {}
  #RDS Auroraのインスタンス
  instances                                   = {}
  #RDS Auroraのインスタンスの使用名前プレフィックス
  instances_use_identifier_prefix             = false
  #RDS AuroraのIOPS
  iops                                        = null
  #RDS Auroraのプライマリクラスター
  is_primary_cluster                          = true
  #RDS AuroraのKMSキーID
  kms_key_id                                  = null
  #RDS Auroraのマスターユーザーのパスワードの管理
  manage_master_user_password = true
  #RDS Auroraのマスターユーザーのパスワードの回転
  manage_master_user_password_rotation = false
  #RDS Auroraのマスターユーザーのパスワード
  master_password                             = null
  #RDS Auroraのマスターユーザーのパスワードの即時回転
  master_user_password_rotate_immediately = null
  #RDS Auroraのマスターユーザーのパスワードの自動回転
  master_user_password_rotation_automatically_after_days = null
  #RDS Auroraのマスターユーザーのパスワードの回転期間
  master_user_password_rotation_duration = null
  #RDS Auroraのマスターユーザーのパスワードの回転スケジュール
  master_user_password_rotation_schedule_expression = null
  #RDS AuroraのマスターユーザーのシークレットのKMSキーID
  master_user_secret_kms_key_id = null
  #RDS Auroraのマスターユーザーのユーザー名
  master_username                             = null
  #RDS Auroraの最大ACU
  max_acu = null
  #RDS Auroraの最小ACU
  min_acu = null
  #RDS Auroraのモニタリング間隔
  monitoring_interval                         = 0
  #RDS AuroraのモニタリングロールのARN
  monitoring_role_arn                         = null
  #RDS Auroraの名前
  name                                        = ""
  #RDS Auroraのネットワークタイプ
  network_type                                = null
  #RDS Auroraのパフォーマンスインサイトの有効化
  performance_insights_enabled                = null
  #RDS AuroraのパフォーマンスインサイトのKMSキーID
  performance_insights_kms_key_id             = null
  #RDS Auroraのパフォーマンスインサイトの保持期間
  performance_insights_retention_period       = null
  #RDS Auroraのポート
  port                                        = null
  #RDS Auroraのパフォーマンスインサイトのタイプ
  predefined_metric_type                      = "RDSReaderAverageCPUUtilization"
  #RDS Auroraのバックアップウィンドウ
  preferred_backup_window                     = "02:00-03:00"
  #RDS Auroraのメンテナンスウィンドウ
  preferred_maintenance_window                = "sun:05:00-sun:06:00"
  #RDS Auroraのパブリックアクセス
  publicly_accessible                         = null
  #RDS Auroraのポリシー
  putin_khuylo = null
  #RDS Auroraのレプリケーションソースの識別子
  replication_source_identifier               = null
  #RDS Auroraの復元ポイント
  restore_to_point_in_time                    = {}
  #RDS AuroraのS3インポート
  s3_import                                   = {}
  #RDS Auroraのスケーリング設定
  scaling_configuration                       = {}
  #RDS Auroraのセキュリティグループの説明
  security_group_description                  = null
  #RDS Auroraのセキュリティグループの名前
  security_group_name                         = ""
  #RDS Auroraのセキュリティグループのルール
  security_group_rules                        = {}
  #RDS Auroraのセキュリティグループのタグ
  security_group_tags                         = {}
  #RDS Auroraのセキュリティグループの使用名前プレフィックス
  security_group_use_name_prefix              = true
  #RDS AuroraのサーバーレスV2スケーリング設定
  serverlessv2_scaling_configuration          = {}
  #RDS Auroraのシャードグループのタグ
  shard_group_tags                            = {}
  #RDS Auroraのシャードグループのタイムアウト
  shard_group_timeouts                        = {}
  #RDS Auroraの最終スナップショットのスキップ
  skip_final_snapshot                         = false
  #RDS Auroraのスナップショットの識別子
  snapshot_identifier                         = null
  #RDS Auroraのソースリージョン
  source_region                               = null
  #RDS Auroraのストレージの暗号化
  storage_encrypted                           = true
  #RDS Auroraのストレージのタイプ
  storage_type                                = null
  #RDS Auroraのサブネット
  subnets                                     = []
  #RDS Auroraのタグ
  tags                                        = {}
  #RDS AuroraのVPC ID
  vpc_id                                      = ""
  #RDS AuroraのセキュリティグループのID
  vpc_security_group_ids                      = []
}