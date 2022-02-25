class Spc < Formula
  desc "Spotify CLI"
  version "1.1.1"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/#{version}.tar.gz"
  depends_on "go" => :build
  
  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
  end
  def install
    system "go", "build", "-o", "spc", "-ldflags", "-X github.com/dvdmuckle/spc/cmd.version=#{version}"
    bin.install "spc"

    output = Utils.safe_popen_read({ "SHELL" => "bash" }, bin/"spc", "completion", "bash")
    (bash_completion/"spc").write output

    output = Utils.safe_popen_read({ "SHELL" => "zsh" }, bin/"spc", "completion", "zsh")
    (zsh_completion/"_spc").write output

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
  end
end
