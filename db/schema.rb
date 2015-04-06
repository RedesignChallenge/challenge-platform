# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150402132212) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "approach_ideas", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "approach_stage_id"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "approach_stages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "public"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "incentive"
  end

  create_table "approaches", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "needs"
    t.text     "link"
    t.string   "image"
    t.text     "file"
    t.text     "embed"
    t.datetime "destroyed_at"
    t.integer  "approach_idea_id"
    t.integer  "user_id"
    t.integer  "refinement_parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "approaches", ["cached_votes_down"], name: "index_approaches_on_cached_votes_down", using: :btree
  add_index "approaches", ["cached_votes_score"], name: "index_approaches_on_cached_votes_score", using: :btree
  add_index "approaches", ["cached_votes_total"], name: "index_approaches_on_cached_votes_total", using: :btree
  add_index "approaches", ["cached_votes_up"], name: "index_approaches_on_cached_votes_up", using: :btree
  add_index "approaches", ["cached_weighted_average"], name: "index_approaches_on_cached_weighted_average", using: :btree
  add_index "approaches", ["cached_weighted_score"], name: "index_approaches_on_cached_weighted_score", using: :btree
  add_index "approaches", ["cached_weighted_total"], name: "index_approaches_on_cached_weighted_total", using: :btree

  create_table "approaches_solutions", id: false, force: :cascade do |t|
    t.integer "solution_id", null: false
    t.integer "approach_id", null: false
  end

  add_index "approaches_solutions", ["approach_id"], name: "index_approaches_solutions_on_approach_id", using: :btree
  add_index "approaches_solutions", ["solution_id"], name: "index_approaches_solutions_on_solution_id", using: :btree

  create_table "challenges", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "hashtag"
    t.string   "slug"
    t.string   "video_url"
    t.datetime "ends_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "background"
    t.text     "outcome"
    t.text     "help"
    t.string   "image"
    t.datetime "starts_at"
    t.string   "active_stage"
    t.string   "headline"
    t.text     "incentive"
    t.string   "cta"
    t.string   "banner"
    t.boolean  "featured"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.text     "body"
    t.integer  "user_id",                                 null: false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.boolean  "reported",                default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "embed"
    t.text     "link"
    t.integer  "temporal_parent_id"
    t.datetime "destroyed_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "comments", ["cached_votes_down"], name: "index_comments_on_cached_votes_down", using: :btree
  add_index "comments", ["cached_votes_score"], name: "index_comments_on_cached_votes_score", using: :btree
  add_index "comments", ["cached_votes_total"], name: "index_comments_on_cached_votes_total", using: :btree
  add_index "comments", ["cached_votes_up"], name: "index_comments_on_cached_votes_up", using: :btree
  add_index "comments", ["cached_weighted_average"], name: "index_comments_on_cached_weighted_average", using: :btree
  add_index "comments", ["cached_weighted_score"], name: "index_comments_on_cached_weighted_score", using: :btree
  add_index "comments", ["cached_weighted_total"], name: "index_comments_on_cached_weighted_total", using: :btree
  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "lea_id"
    t.string   "fipst"
    t.string   "stid"
    t.string   "name"
    t.string   "phone"
    t.string   "mail_street"
    t.string   "mail_city"
    t.string   "mail_state"
    t.string   "mail_zip"
    t.string   "mail_zip4"
    t.string   "location_street"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.string   "location_zip4"
    t.string   "_type"
    t.string   "union"
    t.string   "county_number"
    t.string   "county_name"
    t.string   "csa"
    t.string   "cbsa"
    t.string   "metmic"
    t.string   "ulocal"
    t.string   "cdcode"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "bound"
    t.string   "biea"
    t.string   "lowest_grade"
    t.string   "highest_grade"
    t.string   "charter"
    t.string   "number_of_schools"
    t.string   "number_of_students"
    t.string   "number_of_k12s"
    t.string   "number_of_members"
    t.string   "number_of_speceds"
    t.string   "number_of_ells"
    t.integer  "state_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["lea_id"], name: "index_districts_on_lea_id", unique: true, using: :btree

  create_table "districts_users", force: :cascade do |t|
    t.integer "district_id"
    t.integer "user_id"
  end

  create_table "experience_stages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "public"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image"
    t.text     "link"
    t.boolean  "featured"
    t.boolean  "top_comment"
    t.integer  "user_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.text     "embed"
    t.datetime "destroyed_at"
  end

  add_index "experiences", ["cached_votes_down"], name: "index_experiences_on_cached_votes_down", using: :btree
  add_index "experiences", ["cached_votes_score"], name: "index_experiences_on_cached_votes_score", using: :btree
  add_index "experiences", ["cached_votes_total"], name: "index_experiences_on_cached_votes_total", using: :btree
  add_index "experiences", ["cached_votes_up"], name: "index_experiences_on_cached_votes_up", using: :btree
  add_index "experiences", ["cached_weighted_average"], name: "index_experiences_on_cached_weighted_average", using: :btree
  add_index "experiences", ["cached_weighted_score"], name: "index_experiences_on_cached_weighted_score", using: :btree
  add_index "experiences", ["cached_weighted_total"], name: "index_experiences_on_cached_weighted_total", using: :btree

  create_table "experiences_solutions", id: false, force: :cascade do |t|
    t.integer "solution_id",   null: false
    t.integer "experience_id", null: false
  end

  add_index "experiences_solutions", ["experience_id"], name: "index_experiences_solutions_on_experience_id", using: :btree
  add_index "experiences_solutions", ["solution_id"], name: "index_experiences_solutions_on_solution_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "idea_stages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "public"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ideas", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.string   "image"
    t.string   "file"
    t.text     "embed"
    t.integer  "problem_statement_id"
    t.integer  "user_id"
    t.integer  "refinement_parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "destroyed_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
    t.text     "impact"
    t.text     "implementation"
  end

  add_index "ideas", ["cached_votes_down"], name: "index_ideas_on_cached_votes_down", using: :btree
  add_index "ideas", ["cached_votes_score"], name: "index_ideas_on_cached_votes_score", using: :btree
  add_index "ideas", ["cached_votes_total"], name: "index_ideas_on_cached_votes_total", using: :btree
  add_index "ideas", ["cached_votes_up"], name: "index_ideas_on_cached_votes_up", using: :btree
  add_index "ideas", ["cached_weighted_average"], name: "index_ideas_on_cached_weighted_average", using: :btree
  add_index "ideas", ["cached_weighted_score"], name: "index_ideas_on_cached_weighted_score", using: :btree
  add_index "ideas", ["cached_weighted_total"], name: "index_ideas_on_cached_weighted_total", using: :btree

  create_table "ideas_solutions", id: false, force: :cascade do |t|
    t.integer "solution_id", null: false
    t.integer "idea_id",     null: false
  end

  add_index "ideas_solutions", ["idea_id"], name: "index_ideas_solutions_on_idea_id", using: :btree
  add_index "ideas_solutions", ["solution_id"], name: "index_ideas_solutions_on_solution_id", using: :btree

  create_table "panels", force: :cascade do |t|
    t.text     "about"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "panels_users", id: false, force: :cascade do |t|
    t.integer "panel_id", null: false
    t.integer "user_id",  null: false
  end

  add_index "panels_users", ["panel_id"], name: "index_panels_users_on_panel_id", using: :btree
  add_index "panels_users", ["user_id"], name: "index_panels_users_on_user_id", using: :btree

  create_table "problem_statements", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "idea_stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "nces_id"
    t.string   "fipst"
    t.string   "lea_id"
    t.string   "school_id"
    t.string   "stid"
    t.string   "sea_school_id"
    t.string   "lea_name"
    t.string   "name"
    t.string   "phone"
    t.string   "mail_street"
    t.string   "mail_city"
    t.string   "mail_state"
    t.string   "mail_zip"
    t.string   "mail_zip4"
    t.string   "location_street"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_zip"
    t.string   "location_zip4"
    t.string   "_type"
    t.string   "status"
    t.string   "ulocal"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "county_number"
    t.string   "county_name"
    t.string   "cdcode"
    t.string   "ft_teachers"
    t.string   "lowest_grade"
    t.string   "highest_grade"
    t.string   "level"
    t.string   "title1"
    t.string   "stitle1"
    t.string   "magnet"
    t.string   "charter"
    t.string   "shared"
    t.string   "bies"
    t.integer  "district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["nces_id"], name: "index_schools_on_nces_id", unique: true, using: :btree

  create_table "schools_users", force: :cascade do |t|
    t.integer "school_id"
    t.integer "user_id"
  end

  create_table "solution_stages", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "active"
    t.boolean  "public"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "challenge_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solution_stories", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.text     "embed"
    t.string   "image"
    t.datetime "destroyed_at"
    t.integer  "solution_stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "solutions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "needs"
    t.string   "effort"
    t.text     "link"
    t.text     "embed"
    t.string   "image"
    t.string   "file"
    t.datetime "destroyed_at"
    t.integer  "solution_story_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "solutions", ["cached_votes_down"], name: "index_solutions_on_cached_votes_down", using: :btree
  add_index "solutions", ["cached_votes_score"], name: "index_solutions_on_cached_votes_score", using: :btree
  add_index "solutions", ["cached_votes_total"], name: "index_solutions_on_cached_votes_total", using: :btree
  add_index "solutions", ["cached_votes_up"], name: "index_solutions_on_cached_votes_up", using: :btree
  add_index "solutions", ["cached_weighted_average"], name: "index_solutions_on_cached_weighted_average", using: :btree
  add_index "solutions", ["cached_weighted_score"], name: "index_solutions_on_cached_weighted_score", using: :btree
  add_index "solutions", ["cached_weighted_total"], name: "index_solutions_on_cached_weighted_total", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "fipst"
    t.string   "name"
    t.string   "mail_street"
    t.string   "mail_city"
    t.string   "mail_state"
    t.string   "mail_zip"
    t.string   "mail_zip4"
    t.string   "phone"
    t.string   "number_of_members"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "states", ["fipst"], name: "index_states_on_fipst", unique: true, using: :btree

  create_table "states_users", force: :cascade do |t|
    t.integer "state_id"
    t.integer "user_id"
  end

  create_table "steps", force: :cascade do |t|
    t.integer  "display_order"
    t.string   "title"
    t.text     "description"
    t.integer  "steppable_id"
    t.string   "steppable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suggestions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.text     "link"
    t.text     "embed"
    t.string   "image"
    t.datetime "destroyed_at"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cached_votes_total",      default: 0
    t.integer  "cached_votes_score",      default: 0
    t.integer  "cached_votes_up",         default: 0
    t.integer  "cached_votes_down",       default: 0
    t.integer  "cached_weighted_score",   default: 0
    t.integer  "cached_weighted_total",   default: 0
    t.float    "cached_weighted_average", default: 0.0
  end

  add_index "suggestions", ["cached_votes_down"], name: "index_suggestions_on_cached_votes_down", using: :btree
  add_index "suggestions", ["cached_votes_score"], name: "index_suggestions_on_cached_votes_score", using: :btree
  add_index "suggestions", ["cached_votes_total"], name: "index_suggestions_on_cached_votes_total", using: :btree
  add_index "suggestions", ["cached_votes_up"], name: "index_suggestions_on_cached_votes_up", using: :btree
  add_index "suggestions", ["cached_weighted_average"], name: "index_suggestions_on_cached_weighted_average", using: :btree
  add_index "suggestions", ["cached_weighted_score"], name: "index_suggestions_on_cached_weighted_score", using: :btree
  add_index "suggestions", ["cached_weighted_total"], name: "index_suggestions_on_cached_weighted_total", using: :btree

  create_table "themes", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "experience_stage_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",        null: false
    t.string   "encrypted_password",     default: "",        null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "role"
    t.string   "organization"
    t.boolean  "admin",                  default: false
    t.string   "ga_dimension"
    t.string   "title"
    t.boolean  "video_access",           default: false
    t.string   "twitter"
    t.string   "avatar"
    t.boolean  "future_participant",     default: true
    t.string   "color"
    t.text     "bio"
    t.integer  "referrer_id"
    t.string   "display_name"
    t.string   "avatar_option",          default: "twitter"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "votes", force: :cascade do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.boolean  "vote_flag"
    t.string   "vote_scope"
    t.integer  "vote_weight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "votes", ["votable_id", "votable_type", "vote_scope"], name: "index_votes_on_votable_id_and_votable_type_and_vote_scope", using: :btree
  add_index "votes", ["voter_id", "voter_type", "vote_scope"], name: "index_votes_on_voter_id_and_voter_type_and_vote_scope", using: :btree

end
