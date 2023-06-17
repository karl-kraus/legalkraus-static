<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/person.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select="'Personenregister'"/>
        </xsl:variable>
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
        <html>
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            
            <body class="page">
                <div class="hfeed site" id="page">
                    <xsl:call-template name="nav_bar"/>
                    
                    <div class="container-fluid">                        
                        <div class="card">
                            <div class="card-header">
                                <h1><xsl:value-of select="$doc_title"/></h1>
                            </div>
                            <div class="card-body">                                
                                <table class="table table-striped display" id="tocTable" style="width:100%">
                                    <thead>
                                        <tr>
                                            <th scope="col">Name</th>
                                            <th scope="col">geboren</th>
                                            <th scope="col">gestorben</th>
                                            <th scope="col">Profession</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <xsl:for-each select=".//tei:person[@xml:id]">
                                            <xsl:variable name="id">
                                                <xsl:value-of select="data(@xml:id)"/>
                                            </xsl:variable>
                                            <tr>
                                                <td>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="concat($id, '.html')"/>
                                                        </xsl:attribute>
                                                    <xsl:choose>
                                                        <xsl:when test="./tei:persName/tei:forename">
                                                            <xsl:value-of select=".//tei:surname/text()"/>,  <xsl:value-of select=".//tei:forename/text()"/>
                                                        </xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select=".//tei:surname/text()"/>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                    </a>
                                                </td>
                                                <td>                                        
                                                    <xsl:value-of select="./tei:birth/tei:date/text()"/><xsl:if test="./tei:birth//tei:placeName">, <a>
                                                        <xsl:attribute name="href"><xsl:value-of select="concat(data(./tei:birth/tei:settlement[1]/@key[1]), '.html')"/></xsl:attribute><xsl:value-of select="./tei:birth//tei:placeName[1]/text()"/></a></xsl:if>
                                                </td>
                                                <td>                                        
                                                    <xsl:value-of select="./tei:death/tei:date/text()"/><xsl:if test="./tei:death//tei:placeName">, <a>
                                                        <xsl:attribute name="href"><xsl:value-of select="concat(data(./tei:death/tei:settlement[1]/@key[1]), '.html')"/></xsl:attribute><xsl:value-of select="./tei:death//tei:placeName[1]/text()"/></a></xsl:if>
                                                </td>
                                                <td>
                                                    <ul class="list-unstyled">
                                                        <xsl:for-each select=".//tei:occupation">
                                                            <li><xsl:value-of select="./text()"/></li>
                                                        </xsl:for-each>
                                                    </ul>
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
        <!--<xsl:for-each select=".//tei:person[@xml:id]">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
            <xsl:variable name="name" select="normalize-space(string-join(./tei:persName//text()))"></xsl:variable>
            <xsl:result-document href="{$filename}">
                <html xmlns="http://www.w3.org/1999/xhtml">
                    <xsl:call-template name="html_head">
                        <xsl:with-param name="html_title" select="$name"></xsl:with-param>
                    </xsl:call-template>
                    
                    <body class="page">
                        <div class="hfeed site" id="page">
                            <xsl:call-template name="nav_bar"/>
                            
                            <div class="container-fluid">
                                <div class="card">
                                    <div class="card-header">
                                        <h1>
                                            <xsl:value-of select="$name"/>
                                        </h1>
                                    </div>
                                    <div class="card-body">
                                        <xsl:call-template name="person_detail"/>  
                                    </div>
                                </div>
                            </div>
                            
                            <xsl:call-template name="html_footer"/>
                        </div>
                    </body>
                </html>
            </xsl:result-document>
            
        </xsl:for-each>-->
    </xsl:template>
    
</xsl:stylesheet>