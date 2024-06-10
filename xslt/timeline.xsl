<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:array="http://www.w3.org/2005/xpath-functions/array"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes"
        omit-xml-declaration="yes"/>
    <xsl:mode on-no-match="deep-skip"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:import href="partials/osd-container.xsl"/>
    <xsl:import href="partials/tei-facsimile.xsl"/>
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="de">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title"
                        select="'Karl Kraus Rechtsakten - Zeitstrahl'"/>
                </xsl:call-template>
                <style>
                    .highcharts-yaxis,
                    .highcharts-axis-line {
                        display: none;
                    }
                    .highcharts-tick {
                        stroke: #fff;
                    }
                    .highcharts-label-box {
                        stroke: #C85545;
                        stroke-width: 1;
                        fill: rgba(247,247,247,0.85);
                    }
                </style>
            </head>
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="index.html">Home</a>
                            </li>
                            <li class="breadcrumb-item active text-truncate" aria-current="page">
                                <xsl:value-of select="'Zeitstrahl'"/>
                            </li>
                        </ol>
                    </nav>

                    <div class="container">
                        <div class="col-12">
                            <div id="timeline-chart-container"/>
                        </div>
                    </div>
                    <xsl:call-template name="html_footer">
                        <xsl:with-param name="include_jquery" select="false()"/>                   
                    </xsl:call-template>
                </div>
                <script src="js/lib/highcharts.js"/>
                <script src="js/lib/gantt.js"/>
                <script src="js/timeline.js"/>
               
            </body>
        </html>
    </xsl:template>    
</xsl:stylesheet>
