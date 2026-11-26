return {
  "mistweaverco/kulala.nvim",
  ft = "http",
  opts = {
    split_direction = "horizontal",
    default_view = "headers_body",
    contenttypes = {
      ["application/problem+json"] = {
        formatter = { "jq", "." },
        ft = "json",
      },
    },
  },
}
