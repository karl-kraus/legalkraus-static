<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    
    <xsl:template match="tei:bibl" name="bibl_detail">
        <table class="table entity-table">
            <tbody>
                <xsl:if test="./tei:author">
                <tr>
                    <th>
                        Autor(en)
                    </th>
                    <td>
                        <ul>
                            <xsl:for-each select="./tei:author">
                                <li>
                                    <a href="{concat('https://pmb.acdh.oeaw.ac.at/entity/', replace(@key, 'person__', ''))}">
                                        <xsl:value-of select="."/>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ul>
                    </td>
                </tr>
                </xsl:if>
                <xsl:if test="./tei:date">
                    <tr>
                        <th>
                            Datum
                        </th>
                        <td>
                            <xsl:value-of select="./tei:date"/>
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
                                <xsl:for-each select="./tei:listEvent/tei:event">
                                    <li>
                                        <a href="{replace(./tei:linkGrp/tei:link/@target, '.xml', '.html')}">
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
