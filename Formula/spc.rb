class Spc < Formula
  version "0.5.2"
  desc "A spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"

  bottle :unneeded

  if OS.mac?
    url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc_#{version}_darwin_amd64.tar.gz"
    sha256 "c9e04d20603246ffff6be7dc019319de5382bd9b13869df642afef73fe81c4c5"
  elsif OS.linux?
    url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc_#{version}_linux_amd64.tar.gz"
    sha256 "dd468151ad17efb42e4fb499c01c973bc683d9f5614affca3ff6ca21c3a59a1c"
end

  def install
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

end

end
