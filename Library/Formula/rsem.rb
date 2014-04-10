require "formula"

# Documentation: https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook
#                /home/zxue/.linuxbrew_x86_64_centos6/Library/Contributions/example-formula.rb
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Rsem < Formula
  homepage "http://deweylab.biostat.wisc.edu/rsem/"
  url "http://deweylab.biostat.wisc.edu/rsem/src/rsem-1.2.12.tar.gz"
  sha1 "86b0502f58fba036f720e3549b697f13889741a3"

  # depends_on "cmake" => :build


  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    # system "./configure", "--disable-debug",
    #                       "--disable-dependency-tracking",
    #                       "--disable-silent-rules",
    #                       "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    # system "make", "install" # if this fails, try separate make/make install steps
    system "make" # if this fails, try separate make/make install steps

    bin.install %w{
rsem-run-ebseq
convert-sam-for-rsem
rsem-plot-model
rsem-prepare-reference
rsem-generate-ngvector
extract-transcript-to-gene-map-from-trinity
rsem-control-fdr
rsem-gen-transcript-plots
rsem-generate-data-matrix
rsem-plot-transcript-wiggles
rsem-calculate-expression
rsem-extract-reference-transcripts
rsem-synthesis-reference-transcripts
rsem-preref
rsem-parse-alignments
rsem-build-read-index
rsem-run-em
rsem-tbam2gbam
rsem-run-gibbs
rsem-calculate-credibility-intervals
rsem-simulate-reads
rsem-bam2wig
rsem-get-unique
rsem-bam2readdepth
rsem-sam-validator
rsem-scan-for-paired-end-reads}
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test rsem`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "rsem-calculate-expression"
  end
end
