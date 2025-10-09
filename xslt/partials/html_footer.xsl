<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:template match="/" name="html_footer">
        <xsl:param name="include_jquery" select="true()" />


        <footer tabindex="-1" class="bg-dark-gray fs-9 mt-auto">
            <div class="row p-5 gx-0 d-flex justify-content-between">
                <div class="col-xs-12 col-md-4">
                    <p class="fw-bolder mb-0"> Karl Kraus: Rechtsakten der Kanzlei Oskar Samek. <br></br>
                        Wissenschaftliche Edition </p>
                    <p>
                        hg. v. Johannes Knüchel und Isabel Langkabel, auf Grundlage der Vorarbeiten
                        Katharina Pragers, unter Mitarbeit von Laura
                        Untner, Andrea Ortner, Ingo Börner und Vanessa Hannesschläger (Wien
                        2022, 2025)
                    </p>
                    <p class="fw-bolder">
                            <a class="imprint-link" href="imprint.html">Impressum</a>
                    </p>
                </div>
                <div class="col-xs-12 col-md-auto">
                    <p class="fw-bolder">Kontakt</p>
                    <p>Projektleitung: Katharina Prager<br />
                    <a class="fw-bolder link-secondary"
                            href="mailto:katharina.prager@wien.gv.at">katharina.prager@wien.gv.at</a>
                    <br />
                        Wienbibliothek im Rathaus<br /> 1010 Wien, Bartensteingasse 9, 1. Stock</p>
                    <p>Isabel Langkabel<br />
                    <a class="fw-bolder link-secondary"
                            href="mailto:isabel.langkabel@wien.gv.at">isabel.langkabel@wien.gv.at</a>
                    <br />
                        Wienbibliothek im Rathaus<br /> 1010 Wien, Rathaus, Stiege 6</p>
                </div>
            </div>
            <div class="row bg-light-gray gx-0">
                <div class="col-xs-12 col-md-2 py-3 ps-5">
                    <img src="images/acdh-ch-logo96.png" loading="lazy" width="auto" height="70px"
                        alt="acdh-logo" />
                </div>
                <div class="col-xs-12 col-md-4 py-3">
                    <img src="images/stadtwien.svg" loading="lazy" width="auto" height="70px"
                        alt="Stadtwien Logo" />
                </div>
                <div class="col-xs-12 col-md-3 py-3">
                    <img src="images/boltzmann.svg" loading="lazy" width="auto" height="70px"
                        alt="Boltzmann" />
                </div>
                <div class="col-xs-12 col-md-3 py-3">
                    <img src="images/fwf.png" loading="lazy" width="auto" height="70px"
                        alt="acdh-logo" />
                </div>
            </div>
        </footer>

        <xsl:if test="$include_jquery">
            <script src="https://code.jquery.com/jquery-3.6.3.min.js"
                integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU="
                crossorigin="anonymous"></script>
        </xsl:if>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
            crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
            crossorigin="anonymous"></script>
        <script src="js/listStopProp.js"></script>
    </xsl:template>
</xsl:stylesheet>