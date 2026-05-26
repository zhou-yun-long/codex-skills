param(
    [string]$Path = "."
)

$ErrorActionPreference = "SilentlyContinue"
$resolved = Resolve-Path -LiteralPath $Path
if (-not $resolved) {
    Write-Output "path_exists=false"
    exit 0
}

Set-Location -LiteralPath $resolved.Path

$git = Get-Command git
$gh = Get-Command gh

Write-Output "path=$($resolved.Path)"
Write-Output "git_available=$([bool]$git)"
Write-Output "gh_available=$([bool]$gh)"

if ($git) {
    $inside = & git rev-parse --is-inside-work-tree 2>$null
    Write-Output "is_git_repo=$($inside -eq 'true')"

    if ($inside -eq "true") {
        $branch = & git branch --show-current 2>$null
        $status = & git status --short 2>$null
        $remotes = & git remote -v 2>$null

        Write-Output "branch=$branch"
        if ($remotes) {
            Write-Output "remotes_begin"
            $remotes | ForEach-Object { Write-Output $_ }
            Write-Output "remotes_end"
        } else {
            Write-Output "remotes="
        }

        if ($status) {
            Write-Output "status_begin"
            $status | ForEach-Object { Write-Output $_ }
            Write-Output "status_end"
        } else {
            Write-Output "status=clean"
        }
    }
} else {
    Write-Output "is_git_repo=unknown"
}
