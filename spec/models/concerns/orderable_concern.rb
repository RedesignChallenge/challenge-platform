require 'rails_helper'

shared_examples_for 'orderable' do
  let(:model) { described_class }
  let(:entity) { FactoryGirl.create(described_class.to_s.downcase.to_sym) }

  # Since anything that is orderable has comments attached to it,
  # we should be able to simply add comments to the entity.

  it 'updates the comments_count column when comments are added into the entity' do
    add_comment(entity)
    add_comment(entity)
    add_comment(entity)
    entity.reload
    expect(entity.comments_count).to eq 3
  end

  it 'updates the comments_count column when comments are soft deleted from the entity' do
    add_comment(entity)
    add_comment(entity)
    soft_deleted_comment = add_comment(entity)
    expect(entity.comments_count).to eq 3
    soft_delete_comment(soft_deleted_comment)
    entity.reload
    expect(entity.comments_count).to eq 2
  end

  it 'updates the comments_count column when comments are hard deleted from the entity' do
    add_comment(entity)
    add_comment(entity)
    hard_deleted_comment = add_comment(entity)
    expect(entity.comments_count).to eq 3
    hard_delete_comment(hard_deleted_comment)
    entity.reload
    expect(entity.comments_count).to eq 2
  end

  private
  def add_comment(entity)
    comment = Comment.build_from(entity, FactoryGirl.create(:user).id, {body: "Test comment"})
    comment.save!
    comment
  end

  def soft_delete_comment(comment)
    comment.destroy
  end

  def hard_delete_comment(comment)
    comment.really_destroy!
  end
end