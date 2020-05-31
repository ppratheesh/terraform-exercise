resource "aws_key_pair" "web_dev_key" {
  key_name = "web_dev_key"
  public_key = file(var.PUBLIC_KEY)
}
