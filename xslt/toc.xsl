<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Dokumente'"/>
        <html xmlns="http://www.w3.org/1999/xhtml">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb" class="p-3">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="index.html">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page"><xsl:value-of select="$doc_title"/></li>
                        </ol>
                    </nav>
                    <div class="container-fluid">
                        <div class="card rounded-0">
                            <div class="card-header rounded-0 bg-darker-gray">
                                <h1 class="text-center">Dokumentenübersicht</h1>
                            </div>
                            <div class="card-body">
                                <table class="table table-striped display" id="tocTable" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Titel</th>
                                            <th scope="col">Akt</th>
                                            <th scope="col">Datum</th>
                                            <th scope="col">Akteure</th>
                                            <th scope="col">Orte</th>
                                            <th scope="col">Typisierung</th>
                                            <th scope="col">Material</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select="collection('../data/editions?select=*.xml')//tei:TEI">
                                            <xsl:variable name="full_path">
                                                <xsl:value-of select="document-uri(/)"/>
                                            </xsl:variable>
                                            <xsl:variable name="caseId">
                                                <xsl:value-of select="concat(tokenize(data(/tei:TEI/tei:teiHeader/tei:fileDesc/tei:seriesStmt/tei:title/@ref), '/')[last()], '.html')"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>                                        
                                                    <a>
                                                        <xsl:attribute name="href">                                                
                                                            <xsl:value-of select="replace(tokenize($full_path, '/')[last()], '.xml', '.html')"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title/text()"/>
                                                    </a>
                                                </td>
                                                <td>
                                                    <a href="{$caseId}"><xsl:value-of select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:seriesStmt/tei:title/text()"/></a>
                                                </td>
                                                <td>
                                                    <xsl:choose>
                                                        <xsl:when test="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation/tei:date/@when-iso">
                                                            <xsl:value-of select="data(/tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation/tei:date/@when-iso)"/>
                                                        </xsl:when>
                                                        <xsl:when test="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation/tei:date/text()">
                                                            <xsl:value-of select="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation/tei:date/text()"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>ohne Datum</xsl:otherwise>
                                                    </xsl:choose>
                                                </td>
                                                <td>
                                                    <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:listPerson/tei:person/tei:persName[1]">
                                                        <span class="badge rounded-pill m-1 bg-aquamarin"><xsl:value-of select="normalize-space(string-join(.//text()))"/></span>
                                                    </xsl:for-each>
                                                </td>
                                                <td>
                                                    <xsl:for-each select="/tei:TEI/tei:text/tei:back/tei:listPlace/tei:place/tei:placeName[1]">
                                                        <span class="badge rounded-pill m-1 bg-dark-violett"><xsl:value-of select="normalize-space(string-join(.//text()))"/></span>
                                                    </xsl:for-each>
                                                </td>
                                                <td>
                                                    <xsl:for-each select="/tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords/tei:term">
                                                        <span class="badge rounded-pill m-1 bg-darker-blue"><xsl:value-of select="./text()"/></span>
                                                    </xsl:for-each>
                                                </td>
                                                <td>
                                                    <xsl:for-each select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc/tei:msDesc/tei:physDesc/tei:ab/tei:objectType">
                                                        <span class="badge rounded-pill m-1 bg-darker-red"><xsl:value-of select="./text()"/></span>
                                                    </xsl:for-each>
                                                </td>  
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    
                    <xsl:call-template name="html_footer"/>
                    <script type="text/javascript" src="https://cdn.datatables.net/v/bs4/jszip-2.5.0/dt-1.11.0/b-2.0.0/b-html5-2.0.0/cr-1.5.4/r-2.2.9/sp-1.4.0/datatables.min.js"></script>
                    <script type="text/javascript" src="js/dt.js"></script>
                    <script>
                        $(document).ready(function () {
                            createDataTable('tocTable');
                        });
                    </script>
                </div>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="tei:div//tei:head">
        <h2 id="{generate-id()}"><xsl:apply-templates/></h2>
    </xsl:template>
    
    <xsl:template match="tei:p">
        <p id="{generate-id()}"><xsl:apply-templates/></p>
    </xsl:template>
    
    <xsl:template match="tei:list">
        <ul id="{generate-id()}"><xsl:apply-templates/></ul>
    </xsl:template>
    
    <xsl:template match="tei:item">
        <li id="{generate-id()}"><xsl:apply-templates/></li>
    </xsl:template>
    <xsl:template match="tei:ref">
        <xsl:choose>
            <xsl:when test="starts-with(data(@target), 'http')">
                <a>
                    <xsl:attribute name="href"><xsl:value-of select="@target"/></xsl:attribute>
                    <xsl:value-of select="."/>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
</xsl:stylesheet>