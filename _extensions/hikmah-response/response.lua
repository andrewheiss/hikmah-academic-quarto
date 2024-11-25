local function endTypstBlock(blocks)
    local lastBlock = blocks[#blocks]
    if lastBlock.t == "Para" or lastBlock.t == "Plain" then
        lastBlock.content:insert(pandoc.RawInline('typst', '\n]'))
        return blocks
    else
        blocks:insert(pandoc.RawBlock('typst', ']\n'))
        return blocks
    end
end

function Div(el)
    if el.classes:includes('memo-excerpt') then
        local blocks = pandoc.List({
            pandoc.RawBlock('typst', '#excerpt[')
        })
        blocks:extend(el.content)
        return endTypstBlock(blocks)
    elseif el.classes:includes('memo-reviewer') then
        local blocks = pandoc.List({
            pandoc.RawBlock('typst', '#reviewer[')
        })
        blocks:extend(el.content)
        return endTypstBlock(blocks)
    elseif el.classes:includes('memo-footnote-excerpt') then
        local blocks = pandoc.List({
            pandoc.RawBlock('typst', '#footnote-excerpt[')
        })
        blocks:extend(el.content)
        return endTypstBlock(blocks)
    end
end

function Span(el)
    if el.classes:includes('memo-excerpt-inline') then
        local inlines = pandoc.List({
            pandoc.RawInline('typst', '#excerpt-inline['),
        })
        inlines:extend(el.content)
        inlines:insert(pandoc.RawInline('typst', ']'))
        return inlines
    elseif el.classes:includes('memo-reviewer-inline') then
        local inlines = pandoc.List({
            pandoc.RawInline('typst', '#reviewer-inline['),
        })
        inlines:extend(el.content)
        inlines:insert(pandoc.RawInline('typst', ']'))
        return inlines
    end
end
