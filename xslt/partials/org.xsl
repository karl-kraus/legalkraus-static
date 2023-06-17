<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    
    <xsl:template match="tei:org" name="org_detail">
        <table class="table entity-table">
            <tbody>
                <xsl:if test="./tei:orgName">
                    <tr>
                        <th>
                            Name
                        </th>
                        <td>
                            <ul>
                                <xsl:for-each select="./tei:orgName">
                                    <li><xsl:value-of select="."/></li>
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:desc[@type='entity_type']">
                    <tr>
                        <th>
                            Beschreibung
                        </th>
                        <td>
                            <xsl:value-of select="./tei:desc[@type='entity_type']"/>
                        </td>
                    </tr>
                </xsl:if>
                <xsl:if test="./tei:location[@type='located_in_place']">
                    <tr>
                        <th>
                            Teil von
                        </th>
                        <td>
                            <ul>
                                <xsl:for-each select="./tei:location[@type='located_in_place']">
                                    <xsl:variable name="key" select="./tei:placeName/@key"/>
                                    <xsl:variable name="coords" select="tokenize(./tei:location[@type='coords']/tei:geo, ', ')"/>
                                    <li class="map-coordinates" lat="{$coords[1]}" long="{$coords[2]}" subtitle="{./tei:orgName}">
                                        <a href="{$key}.html">
                                            <xsl:value-of select="./tei:placeName"/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                </xsl:if>
                <tr>
                    <th>links</th>
                    <th>
                        <xsl:for-each select="./tei:idno[@type='URL']">
                            <a>
                                <xsl:attribute name="href">
                                    <xsl:value-of select="./text()"/>
                                </xsl:attribute>
                                <span class="badge rounded-pill m-1 bg-warning"><xsl:value-of select="@subtype"/></span>
                            </a>
                        </xsl:for-each>
                    </th>
                </tr>
                <xsl:if test="./tei:listEvent">
                    <tr>
                        <th>
                            Erwähnt in
                        </th>
                        <td>
                            <ul>
                                <xsl:for-each select=".//tei:event[@type='mentioned']">
                                    <li>
                                        <a href="{replace(tokenize(./tei:linkGrp/tei:link/@target, '/')[last()], '.xml', '.html')}">
                                            <xsl:value-of select="./tei:p/tei:title"/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                </xsl:if>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
