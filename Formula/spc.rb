class Spc < Formula
  desc "Lightweight Spotify CLI"
  homepage "https://github.com/dvdmuckle/spc"
  url "https://github.com/dvdmuckle/spc/archive/refs/tags/1.3.0.tar.gz"
  sha256 "1695c8668de159df99615a20e4bd9dde36e06085ce81dab59259946508c446e0"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    root_url "https://ghcr.io/v2/dvdmuckle/tap"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a2c030d6c1c0ea64cdca01b3de01e3fa1971f59f4940d68803f8b0449ae3d272"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8ce7b559cb7af46862834fae8e96516e2fe97aca09e34a2c9d18dba55154ccb7"
    sha256 cellar: :any_skip_relocation, ventura:       "f3de9716ba20658a67bf3730a1c0e3309f8a9c2a51a9ad79563dc6af895fc3c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f3ab238042839ae4a12f4d7acda0dba2025f5dc31fa92903a63189447cb13937"
  end
  depends_on "go" => :build

  def install
    system "go", "build", "-o", "spc", "-ldflags", "-X github.com/dvdmuckle/spc/cmd.version=#{version}"
    bin.install "spc"

    generate_completions_from_executable(bin/"spc", "completion")

    system bin/"spc", "docs", "man", "man1"
    man.install "man1"
  end
end
