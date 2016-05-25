challenge = Challenge.create!(title: 'The First Challenge',
                              headline: 'This is the first challenge - what\'s not working for you and your setup?',
                              video_url: 'https://youtu.be/3kAo2Z3C3gY',
                              remote_banner_url: '',
                              hashtag: 'ChallengePlatform',
                              description: "<p class='section-title'>What's your idea to make classroom videos great?</p>",
                              background: 'School systems across the country are investing time and money to create and share professional development videos, but are these videos giving educators what they need, when they need it? What if teachers came together to share their experiences and come up with ideas for how videos can better meet their professional learning needs?',
                              outcome: 'The First Challenge is a test challenge.',
                              help: "There are four ways you can get involved over the course of the Challenge: share your experiences, contribute your ideas for how to improve classroom video, develop approaches, and try out popular solutions in your classroom. You'll eventually be able to participate in any stage. Scroll down to learn more, or click \"Get Involved\" to start now. Welcome!",
                              cta: 'Want to help?',
                              starts_at: Time.now,
                              ends_at: 1.month.from_now,
                              featured: true
                              )

## CREATING DEMO PANEL
panel = challenge.create_panel!(about: "Our Challenge Guides are educators and researchers who are passionate about making professional learning the best it can be. They’re here to support and synthesize #{challenge.title} conversation and make sure your voice is heard, your questions are answered and great ideas are shared!", user_ids: [7,8,12])