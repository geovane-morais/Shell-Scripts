export function displayScreen(){
    if (screen.width <= 1600){
        document.querySelector('.display-page').style.cssText =
            `:root{
                --tamanho-header: 4.5em;
                --height-header : 4em;
                --font-main: 20px;
            }`
    }

    if (screen.width <= 1280){
        document.getElementById('.display-page').style.cssText =
            `:root{
                --tamanho-header: 4.5em;
                --height-header : 4em;
                --font-main: 10px;
            }`
    }

    if (screen.width > 1280){
        document.getElementById('.display-page').style.cssText =
            `:root{
                --tamanho-header: 4.5em;
                --height-header : 4em;
                --font-main: 15px;
            }`
    }
    console.log("Import display screen successfull");
}