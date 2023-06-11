<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="#all">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes" />
    <xsl:import href="./partials/html_navbar.xsl" />
    <xsl:import href="./partials/html_head.xsl" />
    <xsl:import href="./partials/html_footer.xsl" />
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select='"Rechtsakten Karl Kraus"' />
        </xsl:variable>

        <xsl:text
            disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            <body class="page" style="background-color:#f1f1f1;">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar" />

                    <div class="container">
                        <div id="carouselExampleControls" class="carousel slide"
                            data-bs-ride="carousel">
                            <div class="carousel-inner">
                                <div class="carousel-item active">
                                    <img src="images/slider1.jpg" class="d-block w-100" alt="..." />
                                </div>
                                <div class="carousel-item">
                                    <img src="images/slider2.jpg" class="d-block w-100" alt="..." />
                                </div>
                                <div class="carousel-item">
                                    <img src="images/slider3.jpg" class="d-block w-100" alt="..." />
                                </div>
                            </div>
                            <button class="carousel-control-prev" type="button"
                                data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Previous</span>
                            </button>
                            <button class="carousel-control-next" type="button"
                                data-bs-target="#carouselExampleControls" data-bs-slide="next">
                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                <span class="visually-hidden">Next</span>
                            </button>
                        </div>
                    </div>
                    <div class="container">
                        <h1>Mögliche Einstiege</h1>
                        <div class="row">
                            <div class="card" style="width: 18rem;">
                                <img src="images/sozialdemokratie.png" class="card-img-top" alt="..." />
                                <div class="card-body">
                                    <p class="card-text"><a href="editionsrichtlinien.html">Editionsrichtlinien</a></p>
                                </div>
                            </div>
                            <div class="card" style="width: 18rem;">
                                <img src="images/fallstatistik.png" class="card-img-top" alt="..." />
                                <div class="card-body">
                                    <p class="card-text">Fallstatistik</p>
                                </div>
                            </div>
                            <div class="card" style="width: 18rem;">
                                <a href="beitraege.html"><img src="images/beitraege.png" class="card-img-top" alt="..." />
                                <div class="card-body">
                                    <p class="card-text">Beiträge</p>
                                </div></a>
                            </div>
                            <div class="card" style="width: 18rem;">
                                <img src="images/verlage.png" class="card-img-top" alt="..." />
                                <div class="card-body">
                                    <p class="card-text"><a href="cases.html">Akten</a></p>
                                </div>
                            </div>
                        </div>
                        <hr class="horizontal  mt-5 mb-3 "/>
                        <div>
                            <div class="mt-3 text-left">
                                <p class="semibold"><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="var(--primary-red)"
                                    class="bi bi-arrow-right"
                                    viewBox="0 0 16 16">
                                    <path fill-rule="evenodd"
                                        d="M1 8a.5.5 0 0 1 .5-.5h11.793l-3.147-3.146a.5.5 0 0 1 .708-.708l4 4a.5.5 0 0 1 0 .708l-4 4a.5.5 0 0 1-.708-.708L13.293 8.5H1.5A.5.5 0 0 1 1 8z"/>
                                </svg><span class="align-bottom">700 Vorlesungen von Karl Kraus</span></p>
                                <p class="w-75 small"><i>Rechtsakten Karl Kraus</i> baut auf <i>Karl Kraus Online</i>, einem Kooperationsprojekt der Wienbibliothek im Rathaus mit dem ehemaligen Ludwig Boltzmann Institut für Geschichte und Theorie der Biografie (2005–2018), auf. Der Rechtsaktenbestand wurde zu der hier vorliegenden Edition aufbereitet und überschrieb somit die ältere Fassung. Die 700 Vorlesungen hingegen liegen noch in der alten Version vor und sind hier zu finden:</p>
                                <p><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="var(--primary-red)" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
                                    <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0v2z"/>
                                    <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z"/>
                                </svg>
                                    <a class="url" href="https://www.kraus-vorleser.wienbibliothek.at/der-vorleser" target="_blank">
                                        https://www.kraus.wienbibliothek.at/der-vorleser
                                    </a></p>
                            </div>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer" />
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}">
            <xsl:apply-templates />
        </h2>
    </xsl:template>

    <xsl:template match="tei:p">
        <p id="{generate-id()}">
            <xsl:apply-templates />
        </p>
    </xsl:template>

    <xsl:template match="tei:list">
        <ul id="{generate-id()}">
            <xsl:apply-templates />
        </ul>
    </xsl:template>

    <xsl:template match="tei:item">
        <li id="{generate-id()}">
            <xsl:apply-templates />
        </li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="@target" /></xsl:attribute>
                    <xsl:value-of select="." />
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>