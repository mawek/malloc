

<%@ page import="malloc.Allocation" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'allocation.label', default: 'Allocation')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
        <div class="nav">
            <span class="menuButton"><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></span>
            <span class="menuButton"><g:link class="list" action="list"><g:message code="default.list.label" args="[entityName]" /></g:link></span>
            <span class="menuButton"><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></span>
        </div>
        <div class="body">
            <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
            <g:if test="${flash.message}">
            <div class="message">${flash.message}</div>
            </g:if>
            <g:hasErrors bean="${allocationInstance}">
            <div class="errors">
                <g:renderErrors bean="${allocationInstance}" as="list" />
            </div>
            </g:hasErrors>
            <g:form method="post" >
                <g:hiddenField name="id" value="${allocationInstance?.id}" />
                <g:hiddenField name="version" value="${allocationInstance?.version}" />
                <div class="dialog">
                    <table>
                        <tbody>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="name"><g:message code="allocation.name.label" default="Name" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'name', 'errors')}">
                                    <g:textField name="name" value="${allocationInstance?.name}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="type"><g:message code="allocation.type.label" default="Type" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'type', 'errors')}">
                                    <g:select name="type" from="${cz.mawek.grails.malloc.domainsupport.AllocationType?.values()}" keys="${cz.mawek.grails.malloc.domainsupport.AllocationType?.values()*.name()}" value="${allocationInstance?.type?.name()}"  />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="requester"><g:message code="allocation.requester.label" default="Requester" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'requester', 'errors')}">
                                    <g:select name="requester.id" from="${malloc.User.list()}" optionKey="id" value="${allocationInstance?.requester?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="date"><g:message code="allocation.date.label" default="Date" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'date', 'errors')}">
                                    
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="hours"><g:message code="allocation.hours.label" default="Hours" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'hours', 'errors')}">
                                    <g:textField name="hours" value="${fieldValue(bean: allocationInstance, field: 'hours')}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="worker"><g:message code="allocation.worker.label" default="Worker" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'worker', 'errors')}">
                                    <g:select name="worker.id" from="${malloc.User.list()}" optionKey="id" value="${allocationInstance?.worker?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="approver"><g:message code="allocation.approver.label" default="Approver" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'approver', 'errors')}">
                                    <g:select name="approver.id" from="${malloc.User.list()}" optionKey="id" value="${allocationInstance?.approver?.id}" noSelection="['null': '']" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="description"><g:message code="allocation.description.label" default="Description" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'description', 'errors')}">
                                    <g:textField name="description" value="${allocationInstance?.description}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="discussion"><g:message code="allocation.discussion.label" default="Discussion" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'discussion', 'errors')}">
                                    
<ul>
<g:each in="${allocationInstance?.discussion?}" var="d">
    <li><g:link controller="discussion" action="show" id="${d.id}">${d?.encodeAsHTML()}</g:link></li>
</g:each>
</ul>
<g:link controller="discussion" action="create" params="['allocation.id': allocationInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'discussion.label', default: 'Discussion')])}</g:link>

                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="link"><g:message code="allocation.link.label" default="Link" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'link', 'errors')}">
                                    <g:textField name="link" value="${allocationInstance?.link}" />
                                </td>
                            </tr>
                        
                            <tr class="prop">
                                <td valign="top" class="name">
                                  <label for="status"><g:message code="allocation.status.label" default="Status" /></label>
                                </td>
                                <td valign="top" class="value ${hasErrors(bean: allocationInstance, field: 'status', 'errors')}">
                                    <g:select name="status" from="${cz.mawek.grails.malloc.domainsupport.AllocationStatus?.values()}" keys="${cz.mawek.grails.malloc.domainsupport.AllocationStatus?.values()*.name()}" value="${allocationInstance?.status?.name()}"  />
                                </td>
                            </tr>
                        
                        </tbody>
                    </table>
                </div>
                <div class="buttons">
                    <span class="button"><g:actionSubmit class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" /></span>
                    <span class="button"><g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" /></span>
                </div>
            </g:form>
        </div>
    </body>
</html>
