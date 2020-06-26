require 'io'

local function split(s, delimiter)
    local splitted = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(splitted, match);
    end
    return splitted;
end

local function Node( value )
    local this = {}
    this.value = value
    this.children = {}
    this.printValue = function()
        for i = 1, #this, 1
        do
            io.write(this[i], " ")
        end
    end
    return this
end

local function Tree()
    local this = {}
    this.root = nil

    this.insert = function (value)
        local data = split(value,"-")
            if (this.root == nil) then

                local node = Node(data[1])
                table.insert(node.children, Node(data[2]))
                this.root = node
                this.root.printValue()
                return
            end
            if (data[1] == this.root.value) then
                padre = this.root
            else
                padre = this.findValue (data[1], this.root.children, 1)
            end
            if (padre ~= nil) then
                table.insert(padre.children, Node(data[2]))
                return true
            end
            return false
    end
    this.findValue = function (value, children, pos)
        if pos >= #children then
                return nil
        end
        if (children[pos].value == value) then
            return children[pos]
        end
        local node = this.findValue (value, children[pos].children)
        if (node ~=  nil) then
            return node
        end
        node = this.findValue (value, children, pos + 1)
        if (node ~= nil) then
            return node
        end
        return nil
    end

    return this
end

local tree = Tree()
tree.insert("C-M")
--print(tree.root.value[1])



