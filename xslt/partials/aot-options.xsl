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
            <a title="Annotationen" href="#" data-bs-toggle="dropdown" data-bs-auto-close="outside" aria-expanded="false" role="button" class="d-md-none p-2 float-end annotation-widget-button justify-content-center align-items-center d-inline-flex rounded-circle link-light align-middle">
               <i class="fas fa-cog fa-lg" title="editor settings"/>
            </a>
            <div class="dropdown-menu rounded-0 inline-menu-md border-0 bg-darker-gray">            
              <ul class="list-unstyled">
                  <li class="d-md-none">
                      <full-size opt="fls"></full-size>
                  </li>
                  <li class="d-md-none">
                      <image-switch opt="es"></image-switch>
                  </li>
              </ul>
              <ul class="row list-unstyled mx-auto">
                  <li class="col-12">
                      <annotation-slider opt="ef"  class="d-flex justify-content-between justify-content-md-end gap-md-3"></annotation-slider>
                  </li>
                  <li class="col-12 col-md-6 col-lg-4">
                      <annotation-slider opt="prs" class="d-flex justify-content-between justify-content-xxl-end gap-xxl-3"></annotation-slider>
                  </li>
                  <li class="col-12 col-md-6 col-lg-4">                  
                      <annotation-slider opt="inst" class="d-flex justify-content-between justify-content-xxl-end gap-xxl-3 "></annotation-slider>
                  </li>
                  <li class="col-12 col-md-6 col-lg-4">
                      <annotation-slider opt="plc" class="d-flex justify-content-between justify-content-xxl-end gap-xxl-3"></annotation-slider>
                  </li>
                  <li class="col-12 col-md-6 col-lg-4">
                      <annotation-slider opt="ltxts" class="d-flex justify-content-between justify-content-xxl-end gap-xxl-3"></annotation-slider>
                  </li>
                  <li class="col-12 col-md-6 col-lg-4">
                      <annotation-slider opt="wrk" class="d-flex justify-content-between justify-content-xxl-end gap-xxl-3"></annotation-slider>
                  </li>
                  <li class="col-12 col-md-6 col-lg-4">
                      <annotation-slider opt="quts" class="d-flex justify-content-between justify-content-xxl-end gap-xxl-3"></annotation-slider>
                  </li>
              </ul>
            </div>                                                    
        </div>
    </xsl:template>
</xsl:stylesheet>