output "kms_key_id" {
    value = "${aws_kms_key.secrethub.key_id}"
}
