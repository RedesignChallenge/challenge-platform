require 'rails_helper'

class Validatable
  include ActiveModel::Validations
  validates_with UrlValidator, attributes: :link
  attr_accessor :link
end

describe UrlValidator do
  subject { Validatable.new }

  it 'does not validate a scheme of FTP' do
    subject.link = 'ftp://youtube.com'
    expect(subject).to_not be_valid
    expect(subject.errors.full_messages).to eq ["Link doesn't contain a valid scheme: ftp://youtube.com"]
  end

  it 'validates a scheme of HTTP' do
    subject.link = 'http://youtube.com'
    expect(subject).to be_valid
    expect(subject.errors.full_messages).to be_empty
  end

  it 'validates a scheme of HTTPS' do
    subject.link = 'https://youtube.com'
    expect(subject).to be_valid
    expect(subject.errors.full_messages).to be_empty
  end

  it 'validates even though the scheme is omitted' do
    subject.link = 'youtube.com'
    expect(subject).to be_valid
    expect(subject.errors.full_messages).to be_empty
  end

  it 'does not validate if the TLD is omitted' do
    subject.link = 'http://youtube/some_url?path=foo&bar'
    expect(subject).not_to be_valid
    expect(subject.errors.full_messages).to eq ['Link hostname is not valid: youtube']
  end

  it 'does not validate if the domain is omitted' do
    subject.link = 'http://..com/some_url?path=foo&bar'
    expect(subject).not_to be_valid
    expect(subject.errors.full_messages).to eq ['Link hostname is not valid: ..com']
  end

  it 'validates well-formed URLs with query parameters' do
    subject.link = 'http://www.youtube.com/some_url?path=left'
    expect(subject).to be_valid
    expect(subject.errors.full_messages).to be_empty

  end

  it 'validates a URL that is 2,046 characters long' do
    subject.link = 'https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0CAcQjRw&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=142349850'
    expect(subject).to be_valid
    expect(subject.errors.full_messages).to be_empty
  end

  it 'validates a URL that is 2,047 characters long' do
    subject.link = 'https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0CAcQjRw&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498501'
    expect(subject).to be_valid
    expect(subject.errors.full_messages).to be_empty
  end

  it 'does not validate a URL that is more than 2,047 characters long' do
    subject.link = 'https://www.google.com/url?sa=i&rct=j&q=&esrc=s&source=images&cd=&cad=rja&uact=8&ved=0CAcQjRw&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=1423498500553233&url=http%3A%2F%2Fwww.theguardian.com%2Fteacher-network%2Fteacher-blog%2F2013%2Foct%2F08%2Fprofessional-development-learn-schools-abroad&ei=nYvXVP-LIISHyQTJlYKICA&bvm=bv.85464276,d.aWw&psig=AFQjCNHqz2xD8wChHtICyG5R29MV8UO0Rg&ust=14234985012'
    expect(subject).not_to be_valid
    expect(subject.errors.full_messages).to eq ['Link is too long, maximum length is 2047 characters']
  end

  it 'does not validate a live XSS attempt from a hacker' do
    subject.link = 'http://asite.com/HTTP-EQUIV="Link" Content="<http://ha.ckers.org/xss.css>; REL=stylesheet"'
    expect(subject).not_to be_valid
  end
end