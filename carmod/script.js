let lastWindow
let moveWindow = false
let windowTemplate
let main
let lua
let buttons

function toTop(element)
{
    main.removeChild(element)
    main.appendChild(element)
}

window.addEventListener("load", function()
{
    main = document.body.getElementsByTagName("main")[0]

    buttons = document.body.getElementsByClassName("mod")

    windowTemplate = document.getElementsByClassName("window")[0]
    windowTemplate.remove()

    document.addEventListener("mousemove", function (e)
    {

        if (moveWindow)
        {
            toTop(lastWindow)
            lastWindow.style.top = "calc("+e.y+"px "+"- 2vh)"
            lastWindow.style.left = "calc("+e.x+"px "+"- 5vh)"

        }
    })


    window.addEventListener('message', function(event) {
        lua = event.data
        document.body.style.display = "initial"
        for (let i = 0; i <25; i++)
        {
            if (lua.mods[i] == -1)
            {
                buttons[i].setAttribute("disabled", "disabled")
            }
        }
    })
})

function move(window)
{
    lastWindow = window
    moveWindow = !moveWindow;
}

function openWindow(mod)
{
    if (mod.obj === undefined)
    {
        let index
        for (let i=0; i<25; i++)
        {
            if (buttons[i] == mod)
            {
                index = i
                break
            }
        }
        mod.obj = windowTemplate.cloneNode(true)
        mod.obj.slider = mod.obj.children[1]
        mod.obj.slider.maxval = mod.obj.slider.children[2]
        mod.obj.slider.currentval = mod.obj.slider.children[3]
        mod.obj.slider.slider = mod.obj.slider.children[1]

        mod.obj.slider.slider.max = (lua.mods[index]+1).toString()
        mod.obj.slider.slider.value = (lua.currentmods[index]+1).toString()
        mod.obj.slider.maxval.textContent = (lua.mods[index]+1).toString()
        mod.obj.slider.currentval.textContent = (lua.currentmods[index]+1).toString()

        mod.obj.creator = mod


        mod.obj.children[0].children[1].textContent = mod.textContent
        main.appendChild(mod.obj)
        mod.obj.appendChild(mod.obj.slider)

    }
    else toTop(mod.obj)

    lastWindow = mod.obj
    mod.obj.style.left = "0px"
    mod.obj.style.top = "0px"

}

function destroy(window)
{
    window.creator.obj = undefined
    window.remove()
    delete window
}


//           LUA COMMUNICATION SECTION           //

function hide()
{
    document.body.style.display = "none"
    fetch(`https://carmod/hide`, { method: 'POST', headers: {'Content-Type': 'application/json; charset=UTF-8'} })
    for (let i = 0; i <= 25; i++)
    {
        try
        {
            buttons[i].removeAttribute("disabled", "disabled")
            destroy(buttons[i].obj)
        } catch {}
    }
}

function changeMod(slider)
{
    let modtype = slider.parentElement.parentElement.creator
    for (let i=0; i<25; i++)
    {
        if (buttons[i] == modtype)
        {
            modtype = i
            break
        }
    }
    lua.currentmods[modtype] = parseInt(slider.value)-1
    slider.parentElement.currentval.textContent = slider.value
    fetch(`https://carmod/changeMod`, { method: 'POST', headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: JSON.stringify({
            type: modtype,
            index: slider.value-1
        })
    })
}
