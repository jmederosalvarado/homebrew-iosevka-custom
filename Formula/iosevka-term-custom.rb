class IosevkaTermCustom < Formula
  desc "Custom build of Iosevka Term font"
  homepage "https://github.com/be5invis/Iosevka"
  # Fetch the latest release tag dynamically, or hardcode a version for stability
  version "latest"
  # Replace with the actual latest release tarball URL and SHA256
  url "https://github.com/be5invis/Iosevka/archive/refs/tags/v33.2.5.tar.gz"
  sha256 ""
  license "OFL-1.1"

  depends_on "node"
  depends_on "ttfautohint"

  def install
    # Copy the build plan from the formula repo
    cp buildpath/"Formula/build-plans.toml", "private-build-plans.toml"

    # Install npm dependencies
    system "npm", "install"

    # Build TTF and TTC fonts
    system "npm", "run", "build", "--", "ttf::IosevkaTermCustom"
    system "npm", "run", "build", "--", "super-ttc::IosevkaTermCustom"

    # Install fonts
    # (share/"fonts").install Dir["dist/IosevkaTermCustom/TTF/*.ttf"]
    (share/"fonts").install Dir["dist/.super-ttc/*.ttc"]
  end

  test do
    # Check that at least one font file was installed
    # assert_predicate Dir[share/"fonts/IosevkaTermCustom-Regular.ttf"], :any?
    assert_predicate Dir[share/"fonts/IosevkaTermCustom-Regular.ttc"], :any?
  end
end
