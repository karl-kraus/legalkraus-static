<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    
    <xsl:template match="/" name="list_mentions">
        <div>
            <h3 class="pt-2">erwähnt in</h3>
            <ul>
                <xsl:for-each select=".//tei:note[@type='mentions']">
                    <li>
                        <a href="{replace(@target, '.xml', '.html')}">
                            <xsl:value-of select="."/>
                        </a>
                    </li>
                </xsl:for-each>
            </ul>
        </div>
        
        
    </xsl:template>
</xsl:stylesheet>
