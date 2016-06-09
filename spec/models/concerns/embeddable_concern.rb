require 'rails_helper'

shared_examples_for 'embeddable' do
  let(:model) { described_class.model_name.param_key.to_sym }

  context 'when parsing image links' do
    it 'generates the correct img tag for PNGs' do
      subject = FactoryGirl.create(model, link: 'http://www.somelink.com/image.png')
      expect(subject.embed).to eql "<img width=\"100%\" src=\"http://www.somelink.com/image.png\" alt=\"Image\" />"
    end

    it 'generates the correct img tag for JPGs' do
      subject = FactoryGirl.create(model, link: 'http://www.somelink.com/image.jpg')
      expect(subject.embed).to eql "<img width=\"100%\" src=\"http://www.somelink.com/image.jpg\" alt=\"Image\" />"
    end

    it 'generates the correct img tag for JPEGs' do
      subject = FactoryGirl.create(model, link: 'http://www.somelink.com/image.jpeg')
      expect(subject.embed).to eql "<img width=\"100%\" src=\"http://www.somelink.com/image.jpeg\" alt=\"Image\" />"
    end

    it 'generates the correct img tag for GIFs' do
      subject = FactoryGirl.create(model, link: 'http://www.somelink.com/image.gif')
      expect(subject.embed).to eql "<img width=\"100%\" src=\"http://www.somelink.com/image.gif\" alt=\"Image\" />"
    end

    it 'does not generate anything for an image link that is not supported' do
      subject = FactoryGirl.create(model, link: 'http://www.somelink.com/image.bmp')
      expect(subject.embed).to be_nil
    end
  end

  context 'when parsing links from YouTube or Vimeo' do
    it 'embeds the correct full YouTube link' do
      subject = FactoryGirl.create(model, link: 'https://www.youtube.com/watch?v=9bZkp7q19f0')
      expect(subject.embed).to eql  "<div class='embed-responsive embed-responsive-16by9'><iframe class='embed-responsive-item' style='max-width:100%' width='560' height='315' src='//www.youtube.com/embed/9bZkp7q19f0?rel=0&showinfo=0' frameborder='0' allowfullscreen></iframe></div>"
    end

    it 'embeds the correct miniaturized YouTube link' do
      subject = FactoryGirl.create(model, link: 'http://youtu.be/9bZkp7q19f0')
      expect(subject.embed).to eql  "<div class='embed-responsive embed-responsive-16by9'><iframe class='embed-responsive-item' style='max-width:100%' width='560' height='315' src='//www.youtube.com/embed/9bZkp7q19f0?rel=0&showinfo=0' frameborder='0' allowfullscreen></iframe></div>"
    end

    it 'embeds the correct Vimeo link' do
      subject = FactoryGirl.create(model, link: 'http://vimeo.com/62552161')
      expect(subject.embed).to eql "<div class='embed-responsive embed-responsive-16by9'><iframe class='embed-responsive-item' style='max-width:100%' width='560' height='315' src='//player.vimeo.com/video/62552161?title=0&byline=0&portrait=0' frameborder='0' allowfullscreen></iframe></div>"
    end
  end

  context 'when parsing a link from Twitter' do

    before(:each) do
      stub_request(:any, /api\.twitter\.com/).
          to_return(:status => 200, :body => '{
                "cache_age": "3153600000",
                "url": "https://twitter.com/Interior/status/507185938620219395",
                "provider_url": "https://twitter.com",
                "provider_name": "Twitter",
                "author_name": "US Dept of Interior",
                "version": "1.0",
                "author_url": "https://twitter.com/Interior",
                "type": "rich",
                "html": "<blockquote class=\"twitter-tweet\"><p>Happy 50th anniversary to the Wilderness Act! Here\'s a great wilderness photo from <a href=\"https://twitter.com/YosemiteNPS\">@YosemiteNPS</a>. <a href=\"https://twitter.com/hashtag/Wilderness50?src=hash\">#Wilderness50</a> <a href=\"http://t.co/HMhbyTg18X\">pic.twitter.com/HMhbyTg18X</a></p>— US Dept of Interior (@Interior) <a href=\"https://twitter.com/Interior/status/507185938620219395\">September 3, 2014</a></blockquote>",
                "height": null,
                "width": 550
              }',
                    :headers => {})
    end

    it 'embeds HTML from Twitter' do
      subject = FactoryGirl.create(model, link: 'https://twitter.com/Interior/status/dummy-id-stubbed-out')
      expect(subject.embed).to eql '<blockquote class="twitter-tweet"><p>Happy 50th anniversary to the Wilderness Act! Here\'s a great wilderness photo from <a href="https://twitter.com/YosemiteNPS">@YosemiteNPS</a>. <a href="https://twitter.com/hashtag/Wilderness50?src=hash">#Wilderness50</a> <a href="http://t.co/HMhbyTg18X">pic.twitter.com/HMhbyTg18X</a></p>— US Dept of Interior (@Interior) <a href="https://twitter.com/Interior/status/507185938620219395">September 3, 2014</a></blockquote>'
    end
  end
end