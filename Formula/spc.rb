class Spc < Formula
  version "1.1.0"
  desc "A spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"

  bottle :unneeded

  if OS.mac?
    url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-darwin-amd64.tar.gz"
    sha256 "658900b5096e3cc58d0d412e79053ada667806c15857fd444b54885e940480d1"
  elsif OS.linux?
    url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc-#{version}-linux-amd64.tar.gz"
    sha256 "c26aa9c4a36a664df9165b8c4077c4bdbee90e8ff4eb64ebdcf96ab0578a8f6d"
end

  def install
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
end

end
