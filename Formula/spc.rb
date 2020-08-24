class Spc < Formula
  version "v0.5.1"
  desc "A spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"

  bottle :unneeded

  if OS.mac?
    url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc_#{version}_darwin_amd64.tar.gz"
    sha256 "4ee81bb82823896fdbdf64903cd5f8b1100373846ee36c389774e321af42d822"
  elsif OS.linux?
    url "https://github.com/dvdmuckle/spc/releases/download/#{version}/spc_#{version}_linux_amd64.tar.gz"
    sha256 "aca8f564ae112b827964420403b2455af516e8951a09427ff39cffaefb198d9f"
end

  def install
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

end

end
