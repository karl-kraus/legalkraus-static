<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:template match="/" name="html_footer">


        <div tabindex="-1" class="custom-footer dunkelgrau">
            <div class="row">
                <div class="col">
                    <p class="b mb-0"> Karl Kraus: Rechtsakten der Kanzlei Oskar Samek. <br></br>
        Wissenschaftliche Edition </p>
                    <p>
                        hg. v. Johannes Knüchel und Isabel Langkabel, auf Grundlage der Vorarbeiten
        Katharina Pragers, unter Mitarbeit von Laura
                        Untner, Andrea Ortner, Ingo Börner und Vanessa Hannesschläger (Wien
                        2022)
                    </p>
                </div>
                <div class="col">
                    <p class="b">Kontakt</p>
                    <p>Projektleitung: Katharina Prager<br />
                            <a class="r b"
                            href="mailto:katharina.prager@wien.gv.at">katharina.prager@wien.gv.at</a><br />
        Wienbibliothek im Rathaus<br /> 1010 Wien, Bartensteingasse 9, 1. Stock</p>

                </div>
                <div class="col">
                    <div>
                        <p class="b">
                            <router-link class="imprint-link" to="/impressum">Impressum</router-link>
                        </p>
                    </div>
                    <p class="b">HELPDESK</p>
                    <p>ACDH runs a helpdesk offering
                        advice for questions related to
                        various digital humanities topics.</p>
                    <div>
                        <svg xmlns="http://www.w3.org/2000/svg" width="26" height="26"
                            fill="#A73D2E" class="bi bi-headset" viewBox="0 0 16 16">
                            <path
                                d="M8 1a5 5 0 0 0-5 5v1h1a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V6a6 6 0 1 1 12 0v6a2.5 2.5 0 0 1-2.5 2.5H9.366a1 1 0 0 1-.866.5h-1a1 1 0 1 1 0-2h1a1 1 0 0 1 .866.5H11.5A1.5 1.5 0 0 0 13 12h-1a1 1 0 0 1-1-1V8a1 1 0 0 1 1-1h1V6a5 5 0 0 0-5-5z" />
                        </svg>
                        <a class="r" href="mailto:acdh-ch-helpdesk@oeaw.ac.at">ASK US!</a>
                    </div>
                </div>
            </div>
            <div class="row custom-footer" >
                <div class="col">
                    <img src="images/acdh-ch-logo96.png" width="auto" height="70px"
                        alt="acdh-logo" />
                </div>
                <div class="col">
                    <img src="images/stadtwien.svg" width="auto" height="70px"
                        alt="Stadtwien Logo" />
                </div>
                <div class="col">
                    <img src="images/boltzmann.svg" width="auto" height="70px"
                        alt="Boltzmann" />
                </div>
                <div class="col">
                    <img src="images/fwf.png" width="auto" height="70px"
                        alt="acdh-logo" />
                </div>
            </div>
        </div>
        
        
        <script
            src="https://code.jquery.com/jquery-3.6.3.min.js"
            integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"
            integrity="sha384-oBqDVmMz9ATKxIep9tiCxS/Z9fNfEXiDAYTujMAeBAsjFuCZSmKbSSUnQlmh/jp3"
            crossorigin="anonymous"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.min.js"
            integrity="sha384-cuYeSxntonz0PPNlHhBs68uyIAVpIIOZZ5JqeqvYYIcEL727kskC66kF92t6Xl2V"
            crossorigin="anonymous"></script>
        <script src="js/listStopProp.js"></script>
        <script
            src="https://cdn.jsdelivr.net/npm/darkmode-js@1.5.7/lib/darkmode-js.min.js"></script>
        <script>
        function addDarkmodeWidget() {
            new Darkmode().showWidget();
            }
            window.addEventListener('load', addDarkmodeWidget);
        </script>
    </xsl:template>
</xsl:stylesheet>