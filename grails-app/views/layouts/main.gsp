<!DOCTYPE html>
<html>
    <head>
        <title><g:layoutTitle default="malloc" /></title>
        <link rel="stylesheet" href="${resource(dir:'css',file:'main.css')}" />
        <link rel="shortcut icon" href="${resource(dir:'images',file:'favicon.ico')}" type="image/x-icon" />
        <g:layoutHead />
        <g:javascript library="application" />
    </head>
    <body>
    	<div id="page">
	        <div id="spinner" class="spinner" style="display:none;">
	            <img src="${resource(dir:'images',file:'spinner.gif')}" alt="${message(code:'spinner.alt',default:'Loading...')}" />
	        </div>
	        
	        <div id="topbar">
	        	<g:render template="/common/topbar" />
	        </div>
	        
	        <div id="header">
	        	<h1>Malloc</h1>
	        </div>
	        
	        <div id="content">
	        	<g:layoutBody />
	        </div>
	        
	        <div id="sidebar">
	        	<g:render template="/common/sidebar" />
	        </div>
	        
	        <div id="footer">
	        	<g:render template="/common/footer" />
	        </div>
        </div>
    </body>
</html>