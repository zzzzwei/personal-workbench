# 个人工作台 → GitHub Pages 一键部署
# 用法：在 personal-workbench 目录下，用 PowerShell 运行本脚本
#   PS> Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
#   PS> .\deploy-github.ps1
# 需要：已安装 Git for Windows；一个带 repo 权限的 Personal Access Token(PAT)

$ErrorActionPreference = 'Stop'

# ===== 启动后按提示填写（回车=用默认值）=====
$ApiBase = Read-Host 'GitHub API 地址（公网直接回车；公司 GHE 填 https://github.giihg.com/api/v3）'
if ([string]::IsNullOrWhiteSpace($ApiBase)) { $ApiBase = 'https://api.github.com' }
$GitHost = Read-Host 'Git 仓库域名（公网直接回车；公司 GHE 填 github.giihg.com）'
if ([string]::IsNullOrWhiteSpace($GitHost)) { $GitHost = 'github.com' }
$Repo = Read-Host '仓库名（回车=personal-workbench）'
if ([string]::IsNullOrWhiteSpace($Repo)) { $Repo = 'personal-workbench' }
# ==============================================

$u = Read-Host 'GitHub 登录名（注意：是登录名，不一定是邮箱）'
$t = Read-Host -AsSecureString 'PAT（需要有 repo 权限）'
$t = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto(
       [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($t))
$enc = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes("$u`:$t"))
$h = @{ Authorization = "Basic $enc"; 'User-Agent' = 'pwb-deploy' }

# 1) 建仓库（已存在则忽略）
$body = @{ name = $Repo; private = $false } | ConvertTo-Json
try {
  Invoke-RestMethod -Uri "$ApiBase/user/repos" -Method Post -Headers $h -Body $body -ContentType 'application/json' | Out-Null
  Write-Host '[ok] 仓库已创建'
} catch {
  Write-Host '[info] 仓库已存在或创建失败，继续（不影响推送）'
}

# 2) 推代码
Set-Location $PSScriptRoot
if (-not (Test-Path .git)) { git init -q }
git branch -M main
git add -A
git commit -qm 'personal workbench' 2>$null
git remote remove origin 2>$null
git remote add origin "https://$u`:$t@$GitHost/$u/$Repo.git"
git push -u origin main

# 3) 开启 GitHub Pages
$pagesBody = @{ source = @{ branch = 'main'; path = '/' } } | ConvertTo-Json
try {
  Invoke-RestMethod -Uri "$ApiBase/repos/$u/$Repo/pages" -Method Post -Headers $h -Body $pagesBody -ContentType 'application/json' | Out-Null
  Write-Host '[ok] Pages 已开启'
} catch {
  Write-Host '[warn] Pages 自动开启失败，请到仓库 Settings -> Pages 手动选 main 分支开启'
}

$pagesUrl = if ($GitHost -like '*giihg*') { '请到仓库 Settings -> Pages 查看实际地址（公司 GHE 域名不同）' } else { "https://$u.github.io/$Repo" }
Write-Host "完成！稍等 1-2 分钟待 Pages 首次构建，访问：$pagesUrl"
Write-Host '（部署完成后建议立即到 GitHub 撤销这个 PAT）'
