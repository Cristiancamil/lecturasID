(function(){
    const menu = document.querySelector('.menu_hamburguer')

    const addClick = ()=> {
        menu.addEventListener('click', ()=> {
            console.log("Hola mundo")
        })
    }

    addClick();
})
