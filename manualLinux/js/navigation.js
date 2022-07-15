const Main = document.getElementById("main-id");
const itemsMain = document.getElementsByClassName("titleH1");

let Nav = document.getElementById("nav-id");
for(let foo=0; foo < itemsMain.length; foo++){
    let H1 = document.createElement("h1")
    let valor = document.createTextNode(itemsMain.item(foo).innerText);
    H1.appendChild(valor);
    Nav.appendChild(H1);
    Nav.children[foo].className = "navList";
}

Nav

const itemsNav = document.getElementsByClassName("navList");

gerarLinksNav (itemsNav,itemsMain);

function gerarLinksNav(btn,itemsMain){
    for(let bar=0; bar < itemsNav.length; bar++){
        itemsNav[bar].classList.add("nav-class-h1");
        itemsNav[bar].classList.add("nav-class-h1:hover");

        if (btn.item(bar) != null){
            btn.item(bar).onclick = () => {
                localizacao = itemsMain.item(bar).getBoundingClientRect().y - window.scrollY - 72;
                window.scroll(0,localizacao);
                if(window.scrollY <= 0){
                    let localizacao = itemsMain.item(bar).getBoundingClientRect().y - window.scrollY - 72;
                    window.scroll(0,localizacao);
                }
                gerarLinksNav(btn,itemsMain);
            }
        }
    }
}