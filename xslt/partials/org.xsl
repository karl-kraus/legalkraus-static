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
                            <ul class="list-unstyled">
                                <xsl:for-each select="./tei:orgName">
                                    <xsl:choose>
                                        <xsl:when test="./@type eq 'werk_link-anno'"></xsl:when>
                                        <xsl:otherwise>
                                            <li><xsl:value-of select="."/></li>
                                        </xsl:otherwise>
                                    </xsl:choose>
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
                            <ul class="list-unstyled">
                                <xsl:for-each select="./tei:location">
                                    <li>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="concat(./tei:placeName/@key, '.html')"/>
                                            </xsl:attribute>
                                            <xsl:value-of select="./tei:placeName/text()"/>
                                        </a>
                                    </li>
                                </xsl:for-each>
                            </ul>
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
