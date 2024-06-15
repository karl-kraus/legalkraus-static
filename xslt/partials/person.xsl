<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:template match="tei:person" name="person_detail">
        <table class="table entity-table">
            <tbody>
                <xsl:if test="./tei:persName[@type]">
                <tr>
                    <th>genannt</th>
                    <td>
                        <ul class="list-unstyled">
                            <xsl:for-each select="./tei:persName[@type]">
                                <li><abbr><xsl:attribute name="title"><xsl:value-of select="@type"/></xsl:attribute><xsl:value-of select="normalize-space(string-join(.//text()))"/></abbr></li> 
                            </xsl:for-each>
                        </ul>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:birth/tei:date">
                <tr>
                    <th>
                        geboren
                    </th>
                    <td>                                        
                        <xsl:value-of select="./tei:birth/tei:date/text()"/><xsl:if test="./tei:birth//tei:placeName">, <a>
                            <xsl:attribute name="href"><xsl:value-of select="concat(data(./tei:birth/tei:settlement[1]/@key[1]), '.html')"/></xsl:attribute><xsl:value-of select="./tei:birth//tei:placeName[1]/text()"/></a></xsl:if>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:death/tei:date">
                <tr>
                    <th>
                        gestorben
                    </th>
                    <td>                                        
                        <xsl:value-of select="./tei:death/tei:date/text()"/><xsl:if test="./tei:death//tei:placeName">, <a>
                            <xsl:attribute name="href"><xsl:value-of select="concat(data(./tei:death/tei:settlement[1]/@key[1]), '.html')"/></xsl:attribute><xsl:value-of select="./tei:death//tei:placeName[1]/text()"/></a></xsl:if>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test=".//tei:occupation">
                    <tr>
                        <th>tätig als</th>
                        <td>
                            <ul class="list-unstyled">
                                <xsl:for-each select=".//tei:occupation">
                                    <li><xsl:value-of select="./text()"/></li>
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test=".//tei:affiliation">
                    <th>
                        steht in Verbindung zu
                    </th>
                    <td>
                        <ul class="list-unstyled">
                            <xsl:for-each select=".//tei:affiliation">
                                <li>
                                    <xsl:value-of select="./tei:term"/>: <a><xsl:value-of select="./tei:orgName/text()"/></a>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </td>
                </xsl:if>
                <tr>
                    <th>links</th>
                    <td>
                        <ul class="list-unstyled">
                        <xsl:for-each select="./tei:idno[@type='URL']">
                            <li>
                                <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="./text()"/>
                                </xsl:attribute>
                                <xsl:value-of select="./text()"/>
                                </a>
                            </li>
                        </xsl:for-each>
                        </ul>
                    </td>
                </tr>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>