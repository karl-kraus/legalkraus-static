<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">

    <xsl:template match="tei:place" name="place_detail">
        <table class="table entity-table">
            <tbody>
                <tr>
                    <th>
                        Ortsname
                    </th>
                    <td>
                        <xsl:choose>
                            <xsl:when test="./tei:settlement/tei:placeName[1]/text()">
                                <xsl:value-of select="./tei:settlement/tei:placeName[1]/text()"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="./tei:placeName[1]/text()"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </td>
                </tr>
                <xsl:if test="./tei:location[@type='located_in_place']">
                    <tr>
                        <th>
                            Teil von
                        </th>
                        <td>
                            <ul>
                                <xsl:for-each select="./tei:location[@type='located_in_place']">
                                    
                                    <li>
                                        <a href="{./tei:placeName/@key}.html">
                                            <xsl:value-of select="./tei:placeName"/>
                                        </a>            
                                    </li>
                                    
                                </xsl:for-each>
                            </ul>
                        </td>
                    </tr>
                </xsl:if> 
                <xsl:if test="./tei:country">
                <tr>
                    <th>
                        Land
                    </th>
                    <td>
                        <xsl:value-of select="./tei:country"/>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:settlement">
                <tr>
                    <th>
                        Ortstyp
                    </th>
                    <td>
                        <xsl:value-of select="./tei:settlement/@type"/>, <xsl:value-of select="./tei:desc[@type='entity_type']"/>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:location">
                <tr>
                    <th>
                        Latitude
                    </th>
                    <td>
                        <xsl:value-of select="tokenize(./tei:location[@type='coords']/tei:geo/text(), '\s')[1]"/>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:location">
                <tr>
                    <th>
                        Longitude
                    </th>
                    <td>
                        <xsl:value-of select="tokenize(./tei:location[@type='coords']/tei:geo/text(), '\s')[2]"/>
                    </td>
                </tr>
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
