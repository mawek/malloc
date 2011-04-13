
<%@ page import="malloc.Allocation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'allocation.label', default: 'Allocation')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.list.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <div class="list">
                <table>
                    <thead>
                        <tr>
                        
                            <g:sortableColumn property="id" title="${message(code: 'allocation.id.label', default: 'Id')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'allocation.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="type" title="${message(code: 'allocation.type.label', default: 'Type')}" />
                        
                            <th><g:message code="allocation.requester.label" default="Requester" /></th>
                        
                            <g:sortableColumn property="when" title="${message(code: 'allocation.when.label', default: 'When')}" />
                        
                            <g:sortableColumn property="hours" title="${message(code: 'allocation.hours.label', default: 'Hours')}" />
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${allocationInstanceList}" status="i" var="allocationInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                        
                            <td><g:link action="show" id="${allocationInstance.id}">${fieldValue(bean: allocationInstance, field: "id")}</g:link></td>
                        
                            <td>${fieldValue(bean: allocationInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: allocationInstance, field: "type")}</td>
                        
                            <td>${fieldValue(bean: allocationInstance, field: "requester")}</td>
                        
                            <td>${fieldValue(bean: allocationInstance, field: "when")}</td>
                        
                            <td>${fieldValue(bean: allocationInstance, field: "hours")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${allocationInstanceTotal}" />
            </div>
        </div>
    </body>
</html>
