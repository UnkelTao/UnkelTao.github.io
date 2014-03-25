module Jekyll
  class TagCloud < Liquid::Tag

    def initialize(tag_name, markup, tokens)
      @opts = {}
      if markup.strip =~ /\s*counter:(\w+)/i
        @opts['counter'] = ($1 == 'true')
        markup = markup.strip.sub(/counter:\w+/i,'')
      end
      super
    end

    def render(context)
      lists = {}
      max, min = 1, 1
      config = context.registers[:site].config
      category_dir = config['root'] + config['category_dir'] + '/'
      categories = context.registers[:site].categories
      categories.keys.sort_by{ |str| str.downcase }.each do |category|
        count = categories[category].count
        lists[category] = count
        max = count if count > max
      end

      html = ''
      lists.each do | category, counter |
        url = category_dir + category.to_url
        style = "font-size: #{100 + (60 * Float(counter)/max)}%"
        html << "<a href='#{url}' style='#{style}'>#{category}"
        if @opts['counter']
          html << "(#{categories[category].count})"
        end
        html << "</a> "
      end
      html
    end
  end

  class CategoryListTag < Liquid::Tag
    def render(context)
      html = ""
      categories = context.registers[:site].categories.keys
      categories.sort.each do |category|
        posts_in_category = context.registers[:site].categories[category].size
        category_dir = context.registers[:site].config['category_dir']
        # category_url = File.join(category_dir, category.gsub(/_|\P{Word}/, '-').gsub(/-{2,}/, '-').downcase)
        category_url = category_dir + "/" + category.to_url
        html << "<li class='category'><a href='/#{category_url}/'>#{category} (#{posts_in_category})</a></li>\n"
      end
      html
    end
  end

end

Liquid::Template.register_tag('tag_cloud', Jekyll::TagCloud)
Liquid::Template.register_tag('category_list', Jekyll::CategoryListTag)