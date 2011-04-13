
<%@ page import="malloc.User" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">            
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
                            <g:sortableColumn property="code" title="${message(code: 'user.code.label', default: 'Code')}" />
                        
                            <g:sortableColumn property="name" title="${message(code: 'user.name.label', default: 'Name')}" />
                        
                            <g:sortableColumn property="surname" title="${message(code: 'user.surname.label', default: 'Surname')}" />
                        
                            <g:sortableColumn property="email" title="${message(code: 'user.email.label', default: 'Email')}" />
                        
                            <th><g:message code="user.department.label" default="Department" /></th>
                        
                        </tr>
                    </thead>
                    <tbody>
                    <g:each in="${userInstanceList}" status="i" var="userInstance">
                        <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">                        
                                                    
                            <td><g:link action="show" id="${userInstance.id}">${fieldValue(bean: userInstance, field: "code")}</g:link></td>
                        
                            <td>${fieldValue(bean: userInstance, field: "name")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "surname")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "email")}</td>
                        
                            <td>${fieldValue(bean: userInstance, field: "department")}</td>
                        
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
            <div class="paginateButtons">
                <g:paginate total="${userInstanceTotal}" />
            </div>
        </div>
        <div class="nav">            
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
    </body>
</html>
