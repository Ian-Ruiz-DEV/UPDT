*** Settings ***
Library     SeleniumLibrary
Resource    ../shared/support_keywords.resource

*** Variables ***
#Imagen del producto
${img_backpack}    //img[@class="inventory_details_img"]
#Precio del producto
#${price_backpack}    //div[@class="inventory_details_price"]
${text_name_backpack}    //div[contains(text(),'Sauce Labs Backpack')]
${text_price_backpack}    //div[contains(text()[2],'29.99')]
#Botones
${button_add_to_cart}    //button[@id="add-to-cart-sauce-labs-backpack"]
${button_back_to_products}    //button[@id="back-to-products"]
#Validación de estar en la pantalla de productos
${products_label}    //span[contains(text(),'Products')]

*** Keywords ***
COM002.1 - Detalle producto
    # Pantalla
    Wait Until Element is Enabled and Visible    ${img_backpack}    60s
    ${name}    Get Text    ${img_backpack}
    Log To Console    > > Nos encontramos en la pantalla del producto: ${name}
    Capture Page Screenshot    ../screenshots/4.product.png
    # Guarda el nombre del producto de forma global
    Wait Until Element is Enabled and Visible    ${text_name_backpack}    60s
    ${name_product_detail}    Get Text    ${text_name_backpack}
    # Guarda el precio del producto de forma global
    Wait Until Element is Enabled and Visible    ${text_price_backpack}    60s
    ${price_product_detail}    Get Text    ${text_price_backpack}
    #Imprime el nombre y precio del producto
    Log To Console    El precio del producto "${name_product_detail}" es: ${price_product_detail}
    #Clic Add to Cart
    Wait Until Element is Enabled and Visible    ${button_add_to_cart}    60s
    Step    Hacer click en el boton "ADD TO CART"
    Click Button    ${button_add_to_cart}
    #Clic Back to Products
    Wait Until Element is Enabled and Visible    ${button_back_to_products}    60s
    Step    Hacer click en el boton "BACK TO PRODUCTS"
    Click Button    ${button_back_to_products}
    #Valida estar en la pantalla de productos
    ${status}    Run Keyword And Return Status    Element Should Be Visible    ${products_label}
        IF    ${status}
            Log To Console    - - Validación a pantalla de productos exitoso
        ELSE
            Log To Console    - - Validación a pantalla de productos fallido
        END