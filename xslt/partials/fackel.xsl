<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">


    <xsl:template match="tei:bibl" name="fackel_detail">
        <table class="table entity-table">
            <tbody>
                <tr>
                    <th> Autor(en) </th>
                    <td>
                        <a href="{concat(./tei:author/@key, '.html')}">
                            <xsl:value-of select="./tei:author/text()"/>
                        </a>
                    </td>
                </tr>
                <tr>
                    <th> Datum </th>
                    <td>
                        <xsl:value-of select="./tei:date"/>
                    </td>
                </tr>
                <xsl:choose>
                    <xsl:when test="./tei:title[@level='a']">
                        <tr>
                            <th>Ausgabe, Seite</th>
                            <td>
                                <xsl:value-of select="./tei:num[@type = 'volume']/text()"/>, <xsl:value-of
                                    select="./tei:biblScope/text()"/>
                            </td>
                        </tr>
                    </xsl:when>
                </xsl:choose>
                
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
