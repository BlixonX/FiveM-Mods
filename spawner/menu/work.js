//const catStyle = "position: relative;display: grid;grid-template-columns: repeat(auto-fit, 165px);grid-template-rows: repeat(auto-fit, 120px);width: 98.7%;height: 100%;grid-gap: 5px;padding: 5px;"
let buttons
let categories

let styl = document.createElement("style")
styl.textContent = ".slot:hover { border: 1px #fff solid; }"
document.head.appendChild(styl)

window.addEventListener("load", function()
{
    categories = document.getElementsByClassName('veh')
    categories[0].style.display = "grid"
    buttons = document.getElementById("tab1")
})

window.onload = function()
{
    window.addEventListener('message', function(event)
    {
        let item = event.data
        if (item.display === true)
        {
            document.body.style.display = "initial";
        }
        else
        {
            document.body.style.display = "none";
        }
    })

}


let currentCar
function selectCar(car)
{
    try
    {
        //currentCar.style.border = "1px black solid"
        currentCar.removeAttribute("id")
    } catch {}
    console.log(car.textContent)
    //car.style.border = "1px orange solid"
    car.setAttribute("id", "select")
    currentCar = car
}



//document.getElementsByClassName('veh').style.cssText = catStyle
let currentCat = 0
function changeCat(button)
{
    categories[currentCat].style.display = "none"
    currentCat = Array.prototype.indexOf.call(buttons.children, button)
    categories[currentCat].style.display = "grid"
}

let currentColorPrime
let currentColorSecond
function getColorPrime(color)
{
    try
    {
        currentColorPrime.classList.remove("colorSelect")
    } catch {}
    color.classList.add("colorSelect")
    currentColorPrime = color
}

function getColorSecond(color)
{
    try
    {
        currentColorSecond.classList.remove("colorSelect")
    } catch {}
    color.classList.add("colorSelect")
    currentColorSecond = color
}

function exit()
{
    fetch(`https://spawner/unfocus`, { method: 'POST', headers: {'Content-Type': 'application/json; charset=UTF-8'} })
}

function spawn()
{
    let c1,c2
    try {c1 = currentColorPrime.id} catch {c1 = 111}
    try {c2 = currentColorSecond.id} catch {c2 = 12}
    fetch(`https://spawner/spawn`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
        body: JSON.stringify({
            car: currentCar.textContent,
            colorPrime: c1,
            colorSecond: c2
        })
    })
}
