class Spc < Formula
  version "0.5.2"
  desc "A spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"

  bottle :unneeded

  if OS.mac?
    url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc_#{version}_darwin_amd64.tar.gz"
    sha256 "d6564c6e1753db60fdb9743b6aae4481e814f95ae2b8f2fde2a838630e6a96e7"
  elsif OS.linux?
    url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc_#{version}_linux_amd64.tar.gz"
    sha256 "46d8faa8a88d9aa0e61317ee5752b7145f99e0ced5bb6645326d8e28d9cd2b63"
end

  def install
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

end

end
