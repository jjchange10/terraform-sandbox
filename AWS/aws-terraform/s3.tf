module "s3" {
  source = "terraform-aws-modules/s3-bucket/aws"
  version = "4.6.0"

  #S3バケットのアクセラレーションステータス
  acceleration_status = null
  #S3バケットのアクセスログ配信ポリシーのソースアカウント
  access_log_delivery_policy_source_accounts = []
  #S3バケットのアクセスログ配信ポリシーのソースバケット
  access_log_delivery_policy_source_buckets = []
  #S3バケットのACL
  acl = null
  #S3バケットの許可されたKMSキーARN
  allowed_kms_key_arn = null
  #S3バケットの分析設定
  analytics_configuration = {}
  #S3バケットの分析設定のソースバケット
  analytics_self_source_destination = false
  #S3バケットの分析設定のソースアカウント
  analytics_source_account_id = null
  #S3バケットの分析設定のソースバケット
  analytics_source_bucket_arn = null
  #S3バケットのアクセスログ配信ポリシーをアタッチ
  attach_access_log_delivery_policy = false
  #S3バケットの分析設定のポリシーをアタッチ
  attach_analytics_destination_policy = false
  #S3バケットの不正な暗号化ヘッダーを拒否するポリシーをアタッチ
  attach_deny_incorrect_encryption_headers = false
  #S3バケットの不正なKMSキーを拒否するポリシーをアタッチ
  attach_deny_incorrect_kms_key_sse = false
  #S3バケットの不正な転送ポリシーをアタッチ
  attach_deny_insecure_transport_policy = false
  #S3バケットの不正な暗号化オブジェクトのアップロードを拒否するポリシーをアタッチ
  attach_deny_ssec_encrypted_object_uploads = false
  #S3バケットの不正な暗号化オブジェクトのアップロードを拒否するポリシーをアタッチ
  attach_deny_unencrypted_object_uploads = false
  #S3バケットのELBログ配信ポリシーをアタッチ
  attach_elb_log_delivery_policy = false
  #S3バケットのインベントリ配信ポリシーをアタッチ
  attach_inventory_destination_policy = false
  #S3バケットのLBログ配信ポリシーをアタッチ
  attach_lb_log_delivery_policy = false
  #S3バケットのポリシーをアタッチ
  attach_policy = false
  #S3バケットのパブリックポリシーをアタッチ
  attach_public_policy = true
  #S3バケットの最新のTLSポリシーをアタッチ
  attach_require_latest_tls_policy = false
  #S3バケットの可用性ゾーンID
  availability_zone_id = null
  #S3バケットのパブリックACLをブロック
  block_public_acls = true
  #S3バケットのパブリックポリシーをブロック
  block_public_policy = true
  #S3バケット名
  bucket = null
  #S3バケットのプレフィックス
  bucket_prefix = null
  #S3バケットのコントロールオブジェクト所有権
  control_object_ownership = false
  #S3バケットのCORSルール
  cors_rule = []
  #S3バケットの作成
  create_bucket = true
  #S3バケットのデータ冗長性
  data_redundancy = null
  #S3バケットの期待される所有者
  expected_bucket_owner = null
  #S3バケットの強制的な削除
  force_destroy = false
  #S3バケットの許可
  grant = []
  #S3バケットのパブリックACLを無視
  ignore_public_acls = true
  #S3バケットのインテリジェントタイピング
  intelligent_tiering = {}
  #S3バケットのインベントリ配信ポリシー
  inventory_configuration = {}
  #S3バケットのインベントリ配信ポリシーのソースバケット
  inventory_self_source_destination = false
  #S3バケットのインベントリ配信ポリシーのソースアカウント
  inventory_source_account_id = null
  #S3バケットのインベントリ配信ポリシーのソースバケット
  inventory_source_bucket_arn = null
  #S3バケットがディレクトリバケットかどうか
  is_directory_bucket = false
  #S3バケットのライフサイクルルール
  lifecycle_rule = []
  #S3バケットの場所タイプ
  location_type = null
  #S3バケットのログ設定
  logging = {}
  #S3バケットのメトリクス設定
  metric_configuration = []
  #S3バケットのオブジェクトロック設定
  object_lock_configuration = {}
  #S3バケットのオブジェクトロックが有効かどうか
  object_lock_enabled = false
  #S3バケットの所有者
  object_ownership = "BucketOwnerEnforced"
  #S3バケットの所有者
  owner = {}
  #S3バケットのポリシー
  policy = null
  #S3バケットのポリシーをアタッチ
  putin_khuylo = true
  #S3バケットのレプリケーション設定
  replication_configuration = {}
  #S3バケットのリクエストペイヤー
  request_payer = null
  #S3バケットのパブリックバケットを制限
  restrict_public_buckets = true
  #S3バケットのサーバーサイド暗号化設定
  server_side_encryption_configuration = {}
  #S3バケットのタグ
  tags = {}
  transition_default_minimum_object_size = null
  type = "Directory"
  versioning = {}
  website = {}
}