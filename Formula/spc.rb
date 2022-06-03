class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/1.1.3.tar.gz"
  sha256 "670b25a5a213a467b10b3fff9cb541e66f897155e8c655c2f0dbbf43f498c5d8"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    sha256 cellar: :any_skip_relocation, big_sur:      "4666594381a21a36c936c6ee57d0b687ddf55ba7128db455bef7323658b7db94"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "643ddb028551056206c79ece3b75cc8eb506ea627cb6fbdd409c20a8002531fe"
  end
  depends_on "go" => :build

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
