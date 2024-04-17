<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs xsl tei" version="2.0">
    <xsl:output encoding="UTF-8" media-type="text/html" method="xhtml" version="1.0" indent="yes" omit-xml-declaration="yes"/>
    
    <doc xmlns="http://www.oxygenxml.com/ns/doc/xsl">
        <desc>
            <h1>Widget annotation options.</h1>
            <p>Contact person: daniel.stoxreiter@oeaw.ac.at</p>
            <p>Applied with call-templates in html:body.</p>
            <p>Custom template to create interactive options for text annoations.</p>
        </desc>    
    </doc>
    
    <xsl:template name="annotation-options">
        <div id="aot-navBarNavDropdown">
            <!-- Your menu goes here -->
            <a title="Annotationen" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false" role="button" class="annotation-widget-button justify-content-center align-items-center d-inline-flex rounded-circle link-light">
               <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-gear" viewBox="0 0 16 16">
                  <path d="M8 4.754a3.246 3.246 0 1 0 0 6.492 3.246 3.246 0 0 0 0-6.492M5.754 8a2.246 2.246 0 1 1 4.492 0 2.246 2.246 0 0 1-4.492 0"/>
                  <path d="M9.796 1.343c-.527-1.79-3.065-1.79-3.592 0l-.094.319a.873.873 0 0 1-1.255.52l-.292-.16c-1.64-.892-3.433.902-2.54 2.541l.159.292a.873.873 0 0 1-.52 1.255l-.319.094c-1.79.527-1.79 3.065 0 3.592l.319.094a.873.873 0 0 1 .52 1.255l-.16.292c-.892 1.64.901 3.434 2.541 2.54l.292-.159a.873.873 0 0 1 1.255.52l.094.319c.527 1.79 3.065 1.79 3.592 0l.094-.319a.873.873 0 0 1 1.255-.52l.292.16c1.64.893 3.434-.902 2.54-2.541l-.159-.292a.873.873 0 0 1 .52-1.255l.319-.094c1.79-.527 1.79-3.065 0-3.592l-.319-.094a.873.873 0 0 1-.52-1.255l.16-.292c.893-1.64-.902-3.433-2.541-2.54l-.292.159a.873.873 0 0 1-1.255-.52zm-2.633.283c.246-.835 1.428-.835 1.674 0l.094.319a1.873 1.873 0 0 0 2.693 1.115l.291-.16c.764-.415 1.6.42 1.184 1.185l-.159.292a1.873 1.873 0 0 0 1.116 2.692l.318.094c.835.246.835 1.428 0 1.674l-.319.094a1.873 1.873 0 0 0-1.115 2.693l.16.291c.415.764-.42 1.6-1.185 1.184l-.291-.159a1.873 1.873 0 0 0-2.693 1.116l-.094.318c-.246.835-1.428.835-1.674 0l-.094-.319a1.873 1.873 0 0 0-2.692-1.115l-.292.16c-.764.415-1.6-.42-1.184-1.185l.159-.291A1.873 1.873 0 0 0 1.945 8.93l-.319-.094c-.835-.246-.835-1.428 0-1.674l.319-.094A1.873 1.873 0 0 0 3.06 4.377l-.16-.292c-.415-.764.42-1.6 1.185-1.184l.292.159a1.873 1.873 0 0 0 2.692-1.115z"/>
                </svg>
            </a>                    
            <ul class="dropdown-menu rounded-0">
                <li class="dropdown-item">
                    <full-size opt="fls"></full-size>
                </li>
                <li class="dropdown-item">
                    <image-switch opt="es"></image-switch>
                </li>
                <li class="dropdown-item">
                    <font-size opt="fs"></font-size>
                </li>
                <li class="dropdown-item">
                    <font-family opt="ff"></font-family>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="ef"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="prs"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="inst"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="plc"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="ltxts"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="wrk"></annotation-slider>
                </li>
                <li class="dropdown-item">
                    <annotation-slider opt="quts"></annotation-slider>
                </li>
            </ul>                                                    
        </div>
    </xsl:template>
</xsl:stylesheet>