
local ok, pickers = pcall(require, "telescope.pickers")
if not ok then
    print "Telescope pickers not found"
    return
end
local ok, finders = pcall(require, "telescope.finders")
if not ok then
    print "Telescope finders not found"
    return
end
local ok, config = pcall(require, "telescope.config")
if not ok then
    print "Telescope config nof found"
    return
end

local conf = config.values

local projects = function(opts)
    opts = opts or {}
    pickers.new(opts, {
        prompt_title = "projects",
        finder = finders.new_table {
            results = {"red", "green", "blue" },
        },
        sorter = conf.generic_sorter(opts),
    }):find()
end

projects()
