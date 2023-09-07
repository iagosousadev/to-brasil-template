<div id="starter" ng-init="" ng-destroy="" data-component="crn-start" screen-params="" primary-datasource="${model.dataSourceName}">
<h1 class="component-holder text-left h3 title" xattr-position="text-left" xattr-type="h3" data-component="crn-text-component" id="crn-text-component-${model.random}"><#if model.realName ?has_content >${model.realName}<#else>${model.dataSourceName}</#if></h1>
<#assign filterSearch = "">
<#if model.initialFilter??>
    <#assign filterSearch = "/${model.initialFilter}">
</#if>
<#assign entitySearch = "">
<#if model.hasColumnFilter()>
    <#assign filterSearch = "{{query == '' || query == null ? '${filterSearch}' : ('/${model.gridFilter}/' + query)}}">
<#else>
    <#assign filterSearch = "">
    <#assign entitySearch = "">
</#if>
<datasource data-component="crn-datasource" filter="${filterSearch}" name="${model.dataSourceName}" entity="${model.dataSourceFullName}" keys="${model.dataSourcePrimaryKeys}" rows-per-page="100" class="" schema="${model.getDSSchema(model.dataSourceName)}" condition="${model.getDSCondition(model.dataSourceName)}" lazy="true"></datasource>

<#if model.hasColumnFilter()>
    <div role="search" ng-hide="${model.dataSourceName}.inserting || ${model.dataSourceName}.editing" class="">
        <div class="form-group">
            <label for="textinput-filter" class="">{{"template.crud.search" | translate}}</label>
            <input type="text" id="textinput-filter" class="form-control k-textbox" ng-model="query" value="%" placeholder="{{'template.crud.search' | translate}}">
        </div>
    </div>
<#else>
    <#if model.getGridFilterSearchable()=="generalSearch">
        <div role="search" ng-hide="${model.dataSourceName}.inserting || ${model.dataSourceName}.editing" data-component="crn-textinput" id="crn-datasource-filter-general${model.random}" class="">
            <div class="form-group">
                <label for="textinput-filter" class="">{{"template.crud.search" | translate}}</label>
                <input type="text" ng-model="vars.search" id="textinput-filter" class="form-control k-textbox" value="" placeholder="{{'template.crud.search' | translate}}">
            </div>
        </div>
    <#elseif model.getGridFilterSearchable()=="specificSearch">
        <#if model.hasSearchableFilter()>
            <div role="search" ng-hide="${model.dataSourceName}.inserting || ${model.dataSourceName}.editing">
                <div class="crn-fieldset">
                    <#list model.formFields as field>
                        <#if field.isSearchable()>
                            <div  data-component="crn-textinput" id="crn-datasource-filter-${field.name}-${model.random}" class="">
                                <div class="form-group" >
                                    <#if field.isBoolean() >
                                        <input type="checkbox" <#if field.isNullable()>crn-allow-null-values="true"<#else>crn-allow-null-values="false"</#if> id="checkbox-filter-${field.name}" ng-model="vars.search${field.name}" class="k-checkbox" value="" placeholder="<#if field.label?has_content>${field.label}<#else>${field.name}</#if>">
                                        <label for="checkbox-filter-${field.name}" class="k-checkbox-label">{{"template.crud.search" | translate}} ${model.formMapLabels[field.name]!}</label>
                                    <#else>
                                        <label for="textinput-filter-${field.name}" class="">{{"template.crud.search" | translate}} ${model.formMapLabels[field.name]!}</label>
                                        <input type="${field.getHtmlType()}" id="textinput-filter-${field.name}" class="form-control k-textbox" ng-model="vars.search${field.name}" mask="${model.formMapMasks[field.name]}" mask-placeholder="" value="" placeholder="<#if field.label?has_content>${field.label}<#else>${field.name}</#if>">
                                    </#if>
                                </div>
                            </div>
                        </#if>
                    </#list>
                </div>
            </div>
        <#else>
            <div role="search" ng-hide="${model.dataSourceName}.inserting || ${model.dataSourceName}.editing" data-component="crn-textinput" id="crn-datasource-filter-${model.getFirstFieldStringNotPk().name}-${model.random}" class="">
                <div class="form-group">
                    <label for="textinput-filter" class="">{{"template.crud.search" | translate}} ${model.formMapLabels[model.getClazz().getSearchField().name]!}</label>
                    <input id="textinput-filter" type="text" class="form-control k-textbox" ng-model="vars.search" value="" placeholder="<#if model.getFirstFieldStringNotPk().label?has_content>${model.getFirstFieldStringNotPk().label}<#else>${model.getFirstFieldStringNotPk().name}</#if>">
                </div>
            </div>
        </#if>
    </#if>
</#if>

<section ng-hide="${model.dataSourceName}.editing || ${model.dataSourceName}.inserting" class="component-holder ng-binding ng-scope" data-component="crn-cron-grid" id="cron-crn-grid-search">
    <cron-grid
            options="${model.getGridOptionsSearch(model.dataSourceName, model.dataSourceName, field)}"
            ng-model="vars.grid${model.random}"
            class=""
            style=""
            scrollable="false">
    </cron-grid>
</section>

<div data-component="crn-form" id="crn-form-form-${model.dataSourceName}-${model.random}">
    <section class="form" ng-show="${model.dataSourceName}.editing || ${model.dataSourceName}.inserting">
        <form crn-datasource="${model.dataSourceName}" class="">
            <div class="tool-bar" ng-hide="datasource.editing || datasource.inserting">
                <div class="component-holder ng-scope" data-component="crn-button" id="crn-button-startInserting">
                    <button class="btn k-button btn-block btn-default btn-fab" ng-click="datasource.startInserting()" aria-label="{{'StartInserting' | translate}}" xattr-fullsize="btn-block" xattr-theme="btn-default" xattr-disabled="">
                        <i class="glyphicon glyphicon-plus" icon-theme=""></i>
                    </button>
                </div>
                <div class="component-holder ng-scope" data-component="crn-button" id="crn-button-startEditing">
                    <button class="btn k-button btn-block btn-default btn-fab" ng-click="datasource.startEditing()" aria-label="{{'startEditing' | translate}}" xattr-fullsize="btn-block" xattr-theme="btn-default" xattr-disabled="">
                        <i class="glyphicon glyphicon-pencil" icon-theme=""></i>
                    </button>
                </div>
                <div class="component-holder ng-scope" data-component="crn-button" id="crn-button-previous">
                    <button class="btn k-button btn-block btn-default btn-fab" ng-click="datasource.previous()" ng-disabled="!datasource.hasPrevious()" aria-label="{{'Before' | translate}}" xattr-fullsize="btn-block" xattr-theme="btn-default" xattr-disabled="">
                        <i class="glyphicon glyphicon-chevron-left" icon-theme=""></i>
                    </button>
                </div>
                <div class="component-holder ng-scope" data-component="crn-button" id="crn-button-next">
                    <button class="btn k-button btn-block btn-default btn-fab" ng-click="datasource.next()" ng-disabled="!datasource.hasNext()" aria-label="{{'Next' | translate}}" xattr-fullsize="btn-block" xattr-theme="btn-default" xattr-disabled="">
                        <i class="glyphicon glyphicon-chevron-right" icon-theme=""></i>
                    </button>
                </div>
                <div class="component-holder ng-scope" data-component="crn-button" id="crn-button-remove">
                    <button class="btn k-button btn-block btn-danger btn-fab" ng-click="datasource.remove()" aria-label="{{'Remove' | translate}}" xattr-fullsize="btn-block" xattr-theme="btn-danger" xattr-disabled="">
                        <i class="glyphicon glyphicon-remove" icon-theme=""></i>
                    </button>
                </div>
            </div>
            <br/>
            <div class="crn-fieldset" ng-disabled="!datasource.editing &amp;&amp; !datasource.inserting">
                <#list model.formFields as field>
                    <#assign currentType = "textinput">
                    <#if field.getProperty("ngOptions")??>
                        <#assign currentType = "enterprise-dynamic-combobox">
                        <datasource data-component="crn-datasource" name="${field.name!?cap_first}Combo" entity="${model.namespace}.${field.type}" keys="${model.getDataSourcePrimaryKeys(field)}" schema="${model.getDSSchema(field.type)}" lazy=true></datasource>
                    </#if>
                    <#assign dataComponentType = "crn-${currentType}">

                    <#if field.isImage()>
                        <#assign dataComponentType = "crn-dynamic-image">
                    <#elseif field.isFile()>
                        <#assign dataComponentType = "crn-dynamic-file">
                    <#elseif (field.isBoolean()) >
                        <#assign dataComponentType = "crn-enterprise-checkbox">
                    </#if>

                    <div data-component="${dataComponentType}" id="crn-${currentType}-${field.name}-${model.random}" class="">
                        <div class="form-group">
                            <#if !field.isBoolean()>
                                <#if field.isImage() || field.isFile()>
                                <label for="${currentType}-${field.name}-button" class="">${model.formMapLabels[field.name]!?cap_first}</label>
                                <#else>
                                <label for="${currentType}-${field.name}" class="">${model.formMapLabels[field.name]!?cap_first}</label>
                                </#if>
                            </#if>
                            <#if field.getProperty("ngOptions")?? >
                                <#assign dataSourceName = "${field.name!?cap_first}Combo">
                                <cron-dynamic-select
                                        <#if !field.isNullable()>required="required"</#if>
                                        id="${currentType}-${field.name}"
                                        name="${currentType}-${field.name}"
                                        options="${model.getComboOptions(field.type, field.getProperty("ngOptionsFkName"), field.getProperty("ngOptions").keys, dataSourceName)}"
                                        ng-model="${model.dataSourceName}.active.${field.name}"
                                        class="crn-select form-control">
                                </cron-dynamic-select>
                            <#elseif field.isBoolean() >
                                <input type="checkbox" <#if field.isNullable()>crn-allow-null-values="true"<#else>crn-allow-null-values="false"</#if> class="k-checkbox" ng-model="${model.dataSourceName}.active.${field.name}" id="${currentType}-${field.name}" placeholder="<#if field.label?has_content>${field.label}<#else>${field.name}</#if>" <#if !field.isNullable()>required="required"</#if>>
                                <label for="${currentType}-${field.name}" class="k-checkbox-label">${model.formMapLabels[field.name]!?cap_first}</label>
                            <#elseif field.isImage()>
                                <div dynamic-image img-alt-text="${model.formMapLabels[field.name]!?cap_first}" id="${currentType}-${field.name}" ng-model="${model.dataSourceName}.active.${field.name}" max-file-size="5MB" class="dynamic-image-container" <#if !field.isNullable()>ng-required="true"<#else>ng-required="false"</#if>>
                                    {{"template.crud.clickOrDragAnImage" | translate}}
                                </div>
                            <#elseif field.isFile()>
                                <div dynamic-file id="${currentType}-${field.name}" ng-model="${model.dataSourceName}.active.${field.name}" max-file-size="5MB" class="dynamic-image-container" <#if !field.isNullable()>ng-required="true"<#else>ng-required="false"</#if>>
                                    {{"template.crud.clickOrDragAnFile" | translate}}
                                </div>
                            <#else>
                                <input
                                        <#if field.getLength()??>
                                            maxlength="${field.getLength()?string["0"]}"
                                        </#if>
                                        type="<#if field.isEncryption()>password<#else>${field.getHtmlType()}</#if>"
                                        ng-model="${model.dataSourceName}.active.${field.name}"
                                        class="form-control k-textbox"
                                        id="${currentType}-${field.name}"
                                        placeholder="<#if field.label?has_content>${field.label}<#else>${field.name}</#if>"
                                        mask="${model.formMapMasks[field.name]}"
                                        mask-placeholder=""
                                        <#assign valid = "" >
                                        <#if model.formMapMasks[field.name] == "999.999.999-99;0" >
                                            <#assign valid = "cpf" >
                                        <#elseif model.formMapMasks[field.name] == "99.999.999/9999-99;0">
                                            <#assign valid = "cnpj" >
                                        </#if>
                                        <#if valid?has_content>
                                            valid="${valid}"
                                            data-error-message="{{'invalid.${valid}' | translate}}"
                                        </#if>
                                        <#if !field.isNullable()>ng-required="true"<#else>ng-required="false"</#if>>
                            </#if>
                        </div>
                    </div>
                </#list>
                <!-- NtoN  -->
                <#list model.formFieldsNToN as field>
                    <#assign relationClassName = "">
                    <#assign dataSourceName = "">
                    <#assign keysDs = "">
                    <#if model.getManyToManyRelationship(field.getName())?? && model.getManyToManyRelationship(field.getName()).getRelationClassField().getClazz()??>
                        <#assign relationClassName = "${model.getManyToManyRelationship(field.getName()).getRelationClassField().getClazz()}">
                        <#if model.getManyToManyRelationship(field.getName()).getRelationClassField().getClazz().getAdjustedFullPrimaryKeys()??>
                            <#assign keysDs = "${model.getJoinKeys(model.getManyToManyRelationship(field.getName()).getRelationClassField().getClazz().getAdjustedFullPrimaryKeys())}">
                        </#if>
                    </#if>

                    <datasource
                            data-component="crn-datasource"
                            name="${relationClassName}"
                            entity="${model.namespace}.${relationClassName}"
                            keys="${keysDs}"
                            dependent-lazy-post="${model.dataSourceName}"
                            rows-per-page="100"
                            parameters="${model.getParametersDataSource(field)}"
                            schema="${model.getDSSchema(relationClassName)}"
                            lazy=true
                    >
                    </datasource>

                    <#if !field.getProperty("NToNOption")?has_content || field.getProperty("NToNOption") == "Lista">
                        <datasource data-component="crn-datasource" name="${field.getName()}NCombo" entity="${model.namespace}.${field.getRelationClazz().getName()}" keys="${model.getJoinKeys(field.getRelationClazz().getAdjustedFullPrimaryKeys())}" schema="${model.getDSSchema(field.getName())}"></datasource>
                        <div class="component-holder ng-binding ng-scope " data-component="crn-enterprise-combobox-multiple" ng-show="datasource.editing || datasource.inserting" >
                            <div class="form-group">
                                <label for="combobox${field.getName()}-container">${field.getName()?cap_first}</label>
                                <cron-multi-select
                                        options="${model.getMultiSelectOptions(field)}"
                                        ng-required="false"
                                        id="combobox${field.getName()}"
                                        name="combobox${field.getName()}"
                                        ng-model="${relationClassName}.data"
                                        class="crn-select form-control" style="">
                                </cron-multi-select>
                            </div>
                        </div>
                    <#else>
                        <h2 class="lead component-holder text-left" data-component="crn-subtitle" xattr-position="text-left" id="crud-title-${model.random}" >${field.getName()?cap_first}</h2>
                        <div class="component-holder ng-binding ng-scope" data-component="crn-cron-grid" id="crn-grid-${field.getName()}-${model.random}">
                            <#assign dataSourceName = "${relationClassName}">
                            <cron-grid options="${model.getGridOptions(relationClassName, dataSourceName, field)}" ng-model="vars.grid${field.getName()}${model.random}" class="" style=""></cron-grid>
                        </div>
                    </#if>
                </#list>
                <!-- NtoN  end-->
            </div>
                <div class="active-bar btn-bar-crud-to" ng-hide="!datasource.editing &amp;&amp; !datasource.inserting">
                    <div class="component-holder ng-scope" data-component="crn-button" id="btn_crud_post_${model.random}">
                        <button class="btn k-button btn-block btn-success btn-crud-to" ng-click="datasource.post()" aria-label="{{'SaveChanges' | translate}}" xattr-fullsize="btn-block" xattr-theme="btn-success" xattr-disabled="">
                            Salvar
                        </button>
                    </div>
                    <div class="component-holder ng-scope" data-component="crn-button" id="btn_crud_cancel_${model.random}">
                        <button class="btn k-button btn-block btn-danger btn-crud-to" ng-click="datasource.cancel()" aria-label="{{'CancelChanges' | translate}}" xattr-fullsize="btn-block" xattr-theme="btn-danger" xattr-disabled="">
                            Cancelar
                        </button>
                    </div>
                </div>
        </form>
    </section>
    <section class="form" ng-show="${model.dataSourceName}.editing || ${model.dataSourceName}.inserting">
        <form>
            <div>
                <!-- OneToN -->
                <#list model.formFieldsOneToN as field>
                    <!--query filter 1toN -->
                    <#assign filterSearch = "">
                    <#assign entitySearch = "">

                    <!-- query filter 1toN end-->
                    <datasource
                            data-component="crn-datasource"
                            filter="${filterSearch}"
                            name="${field.getName()}Grid"
                            entity="${model.namespace}.${field.getName()}"
                            keys="${model.getDataSourcePrimaryKeys(field)}"
                            dependent-lazy-post="${model.dataSourceName}"
                            rows-per-page="100"
                            parameters="${model.getParametersDataSource(field)}"
                            schema="${model.getDSSchema(field.getName())}"
                            lazy=true>
                    </datasource>
                    <!-- teste -->
                    <h2 class="lead component-holder text-left" data-component="crn-subtitle"><#if field.getClazz()?? && field.getClazz().getRealName()?? && field.getClazz().getRealName()?has_content>${field.getClazz().getRealName()}<#else>${field.getName()}</#if> </h2>
                    <div class="component-holder ng-binding ng-scope" data-component="crn-cron-grid" id="crn-grid-${field.getName()}Grid-${model.random}">
                        <#assign classname = "${field.clazz.name}">
                        <#assign dataSourceName = "${classname}Grid">
                        <cron-grid options="${model.getGridOptions(classname, dataSourceName, field)}" ng-model="vars.${dataSourceName}${model.random}" class="" style=""></cron-grid>
                    </div>
                </#list>
                <!-- OneToOne  end -->
            </div>
        </form>
    </section>
</div>

<#if model.hasFieldGridNtoN()?? && model.hasFieldGridNtoN()>
    <#list model.formFieldsNToN as field>
        <#assign nomeModal = "modal${field.getName()}Grid">
        <#if field.isNToN() && field.getProperty("NToNOption")?has_content && field.getProperty("NToNOption") == "Grade">
            <div class="modal fade" id="modal${field.getName()}Grid">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <form>
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="{{'Home.view.Close' | translate}}"><span aria-hidden="true">×</span></button>
                                <h3 class="modal-title">${field.getName()}</h3>
                            </div>
                            <div class="modal-body">
                                <div class="list-group list-group-sm row">
                                    <#assign relationClassName = "">
                                    <#assign dataSourceName = "${field.getClazz().getName()}">
                                    <#assign dataSourceCombo = "${field.fullType}NCombo">
                                    <#assign keyField = "">
                                    <#assign textField = "">
                                    <#if field.getFullType()?? && model.getManyToManyRelationship(field.getFullType())??>
                                        <#assign relationClassName = "${model.getManyToManyRelationship(field.getFullType()).getRelationClass().getName()}">
                                        <#assign keyField = "${model.getJoinKeys(model.getManyToManyRelationship(field.getFullType()).getRelationClass().getPrimaryKeys())}">
                                        <#assign textField = "${model.getManyToManyRelationship(field.getFullType()).getRelationClass().getFirstStringFieldNonPrimaryKey().getName()}">
                                    </#if>

                                    <datasource data-component="crn-datasource" name="${dataSourceCombo}" entity="${model.namespace}.${relationClassName}" keys="${keyField}" schema="${model.getDSSchema(field.fullType)}" lazy=true></datasource>
                                    <div data-component="crn-enterprise-dynamic-combobox" id="modal-combo${field.getName()}-${model.random}" class="component-holder ng-binding ng-scope">
                                        <div class="form-group">
                                            <label for="combobox-modal-${field.getName()}${model.random}" class=""><#if field.label?has_content>${field.label}<#else>${field.name?capitalize}</#if></label>
                                            <cron-dynamic-select
                                                    id="combobox-modal-${field.getName()}${model.random}"
                                                    name="combobox-modal-${field.getName()}${model.random}"
                                                    options="${model.getComboOptions(field.fullType, textField, keyField, dataSourceCombo)}"
                                                    ng-model="${dataSourceName}.active.${field.relationField}"
                                                    class="crn-select form-control" <#if !field.isNullable()>required="required"</#if>>
                                            </cron-dynamic-select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <div class="component-holder ng-scope" data-component="crn-button" id="crn-button-grid-save-button-modal">
                                    <button class="btn k-button btn-block btn-success grid-save-button-modal" ng-click="${dataSourceName}.active.${model.getTextRelationField(field)}=${dataSourceCombo}.active.${textField}; ${dataSourceName}.post();" onclick="(!${dataSourceName}.missingRequiredField()?$('#${nomeModal}').modal('hide'):void(0))" xattr-fullsize="btn-block" xattr-theme="btn-success" xattr-disabled="">
                                        <i class="k-icon k-i-check" icon-theme=""></i>
                                    </button>
                                </div>
                                <div class="component-holder ng-scope" data-component="crn-button" id="crn-button-grid-cancel-button-modal">
                                    <button class="btn k-button btn-block btn-danger" ng-click="${dataSourceName}.active.${model.getTextRelationField(field)}=${dataSourceCombo}.active.${textField}; ${dataSourceName}.post();" onclick="(!${dataSourceName}.missingRequiredField()?$('#${nomeModal}').modal('hide'):void(0))" xattr-fullsize="btn-block" xattr-theme="btn-danger" xattr-disabled="">
                                        <i class="k-icon k-i-cancel" icon-theme=""></i>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

        </#if>
    </#list>
</#if>

<#list model.formFieldsOneToN as field>
    <div class="modal fade" id="modal${field.getName()}Grid">
        <div class="modal-dialog">
            <div class="modal-content">
                <form>
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="{{'Home.view.Close' | translate}}"><span aria-hidden="true">×</span></button>
                        <h3 class="modal-title">${field.getName()}</h3>
                    </div>
                    <div class="modal-body">
                        <div class="list-group list-group-sm row">
                            <#list field.getClazz().getFields() as gField>
                                <#if gField.isReverseRelation() || gField.isRelation() >
                                    <#if (field.getDbFieldName() != gField.getDbFieldName())>
                                        <#assign dataSourceCombo = "${gField.getRelationClazz().getName()}GridForCombo">
                                        <datasource name="${dataSourceCombo}" entity="${model.namespace}.${gField.getRelationClazz().getName()}" keys="${model.getDataSourcePrimaryKeys(gField)}" rows-per-page="100" schema="${model.getDSSchema(gField.getRelationClazz().getName())}" lazy=true></datasource>
                                        <div data-component="crn-enterprise-dynamic-combobox" id="crn-combobox-${field.getName()}Grid.active.${gField.getName()}-${model.random}" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                            <div class="form-group">
                                                <label for="combobox-modal-${gField.getName()}-${model.random}" class=""><#if gField.label?has_content>${gField.label}<#else>${gField.name?capitalize}</#if></label>
                                                <cron-dynamic-select
                                                        <#if !field.isNullable()>required="required"</#if>
                                                        id="combobox-modal-${gField.getName()}-${model.random}"
                                                        name="combobox-modal-${gField.getName()}-${model.random}"
                                                        options="${model.getComboOptions(gField.type, gField.getRelationClazz().getFirstStringFieldNonPrimaryKey().getName(), gField.getRelationClazz().getNameKeys(), dataSourceCombo)}"
                                                        ng-model="${field.getName()}Grid.active.${gField.getName()}"
                                                        class="crn-select form-control">
                                                </cron-dynamic-select>
                                            </div>
                                        </div>
                                    </#if>
                                <#elseif (!gField.isPrimaryKey() || field.getClazz().hasCompositeKey())>
                                    <#assign dataComponentType = "crn-textinput">
                                    <#if gField.isImage()>
                                        <#assign dataComponentType = "crn-dynamic-image">
                                    <#elseif gField.isFile()>
                                        <#assign dataComponentType = "crn-dynamic-file">
                                    <#elseif gField.isBoolean()>
                                        <#assign dataComponentType = "crn-enterprise-checkbox">
                                    </#if>
                                    <div data-component="${dataComponentType}"  id="crn-modal-textinput-${gField.getDbFieldName()}-${model.random}" class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                        <div class="form-group">
                                            <#if !gField.isBoolean()>
                                                <#if gField.isImage() || gField.isFile()>
                                                <label for="textinput-modal-${gField.getDbFieldName()}-button"><#if gField.label?has_content>${gField.label?cap_first}<#else>${gField.name?capitalize}</#if></label>
                                                <#else>
                                                <label for="textinput-modal-${gField.getDbFieldName()}"><#if gField.label?has_content>${gField.label?cap_first}<#else>${gField.name?capitalize}</#if></label>
                                                </#if>
                                            </#if>
                                            <#if gField.isImage()>
                                                <div dynamic-image id="textinput-modal-${gField.getDbFieldName()}" ng-model="${field.getName()}Grid.active.${gField.getName()}" max-file-size="5MB" class="dynamic-image-container" <#if !gField.isNullable()>ng-required="true"<#else>ng-required="false"</#if>>
                                                    {{"template.crud.clickOrDragAnImage" | translate}}
                                                </div>
                                            <#elseif gField.isBoolean() >
                                                <input type="checkbox" <#if gField.isNullable()>crn-allow-null-values="true"<#else>crn-allow-null-values="false"</#if> class="k-checkbox" ng-model="${field.getName()}Grid.active.${gField.getName()}" id="cron-modal-checkbox-${gField.name}" <#if !gField.isNullable()>required="required"</#if>>
                                                <label for="cron-modal-checkbox-${gField.name}" class="k-checkbox-label"><#if gField.label?has_content>${gField.label?cap_first}<#else>${gField.name?capitalize}</#if></label>
                                            <#elseif gField.isFile()>
                                                <div dynamic-file id="textinput-modal-${gField.getDbFieldName()}" ng-model="${field.getName()}Grid.active.${gField.getName()}" max-file-size="5MB" class="dynamic-image-container" <#if !gField.isNullable()>ng-required="true"<#else>ng-required="false"</#if>>
                                                    {{"template.crud.clickOrDragAnFile" | translate}}
                                                </div>
                                            <#else>
                                                <input type="<#if gField.isEncryption()>password<#else>${gField.getHtmlType()}</#if>"
                                                        <#if gField.getLength()??>
                                                            maxlength="${gField.getLength()?string["0"]}"
                                                        </#if>
                                                       ng-model="${field.getName()}Grid.active.${gField.getName()}" class="form-control k-textbox"
                                                       id="textinput-modal-${gField.getDbFieldName()}"
                                                       placeholder="<#if gField.label?has_content>${gField.label}<#else>${gField.name?capitalize}</#if>"
                                                       mask="${model.formMapRelationFieldMasks[gField.name]}"
                                                       mask-placeholder=""
                                                        <#if model.formMapRelationFieldMasks[gField.name] == "999.999.999-99;0" >
                                                            <#assign valid = "cpf" >
                                                        <#elseif model.formMapRelationFieldMasks[gField.name] == "99.999.999/9999-99;0">
                                                            <#assign valid = "cnpj" >
                                                        </#if>
                                                        <#if valid?has_content>
                                                            valid="${valid}"
                                                            data-error-message="{{'invalid.${valid}' | translate}}"
                                                        </#if>
                                                        <#if !gField.isNullable()>ng-required="true"<#else>ng-required="false"</#if>>
                                            </#if>
                                        </div>
                                    </div>
                                </#if>
                            </#list>
                        </div>
                    </div>
                    <div class="modal-footer">
                    </div>
                </form>
            </div>
        </div>
    </div>
</#list>
</div>