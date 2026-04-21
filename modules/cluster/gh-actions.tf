data "tls_certificate" "gh_actions_tls_certificate" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_openid_connect_provider" "gh_actions_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = data.tls_certificate.gh_actions_tls_certificate.certificates[*].sha1_fingerprint
  url             = data.tls_certificate.gh_actions_tls_certificate.url

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-gh-actions-oidc"
    }
  )
}

resource "aws_iam_role" "gh_actions_oidc_role" {
  name = "${var.project_name}-gh-actions-oidc-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${aws_iam_openid_connect_provider.gh_actions_oidc.arn}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "token.actions.githubusercontent.com:aud": "sts.amazonaws.com",
          "token.actions.githubusercontent.com:sub": "repo:gaabrieltorres7/devops-lab:ref:refs/heads/master"
        }
      }
    }
  ]
}
EOF

  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-gh-actions-oidc-role"
    }
  )
}

resource "aws_iam_policy" "gh_actions_ecr_policy" {
  name = "${var.project_name}-gh-actions-ecr-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload",
          "ecr:PutImage"
        ]
        Resource = "arn:aws:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/${var.project_name}-ecr"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "gh_actions_ecr_attachment" {
  role       = aws_iam_role.gh_actions_oidc_role.name
  policy_arn = aws_iam_policy.gh_actions_ecr_policy.arn
}

resource "aws_iam_policy" "gh_actions_eks_readonly_policy" {
  name = "${var.project_name}-gh-actions-eks-readonly-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["eks:DescribeCluster"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "gh_actions_eks_readonly_attachment" {
  role       = aws_iam_role.gh_actions_oidc_role.name
  policy_arn = aws_iam_policy.gh_actions_eks_readonly_policy.arn
}

resource "aws_eks_access_entry" "gh_actions" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  principal_arn = aws_iam_role.gh_actions_oidc_role.arn
  type          = "STANDARD"
}

resource "aws_eks_access_policy_association" "gh_actions" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  principal_arn = aws_iam_role.gh_actions_oidc_role.arn
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  access_scope {
    type = "cluster"
  }
}
