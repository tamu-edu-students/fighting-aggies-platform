# frozen_string_literal: true

class Analysis < ApplicationRecord
  belongs_to :video
  def initialize(video_id)
    # Return if video does not exist
    raise "Video with id #{video_id} does not exist" and return unless Video.exists?(id: video_id)

    vision = Vision.find_by(video_id:)
    vision = Vision.create(video_id) if vision.nil?

    # Return if analysis exists for the requested video_id
    raise "Analysis for video with id #{video_id} already exists" and return if Analysis.exists?(video_id:)

    report = generate_random_report(vision.report)

    super({ report:, video_id: })
  end

  private

  def generate_random_report(_raw_data)
    # parsed_raw_data = JSON.parse(raw_data)

    # play_success = parsed_raw_data['play_success'] == 1 ? 'Pass' : 'Fail'
    # route_wr1_success = parsed_raw_data['WR1_good_route'] == 1 ? 'Pass' : 'Fail'
    # route_wr2_success = parsed_raw_data['WR2_good_route'] == 1 ? 'Pass' : 'Fail'
    # route_te_success = parsed_raw_data['TE_good_route'] == 1 ? 'Pass' : 'Fail'
    # route_rb_success = parsed_raw_data['RB_good_route'] == 1 ? 'Pass' : 'Fail'
    # wr1_yards_gained = parsed_raw_data['WR1_name'] == parsed_raw_data['received_by'] ? parsed_raw_data['yards_gained'] : 0
    # wr2_yards_gained = parsed_raw_data['WR2_name'] == parsed_raw_data['received_by'] ? parsed_raw_data['yards_gained'] : 0
    # te_yards_gained = parsed_raw_data['TE_name'] == parsed_raw_data['received_by'] ? parsed_raw_data['yards_gained'] : 0
    # rb_yards_gained = parsed_raw_data['RB_name'] == parsed_raw_data['received_by'] ? parsed_raw_data['yards_gained'] : 0

    # players_good_routes = 0
    # players_bad_routes = 0
    # for a in [parsed_raw_data['WR1_good_route'],parsed_raw_data['WR2_good_route'],parsed_raw_data['TE_good_route'],parsed_raw_data['RB_good_route']] do
    #     if a==1
    #         players_good_routes += 1
    #     else
    #         players_bad_routes += 1
    #     end
    # end

    frontend_report = {
      'Offense' => [{
        'component' => 'piechart',
        'title' => 'Point Distribution',
        'data' => [{
          'name' => 'Passing Touchdown Points',
          'value' => [0, 6, 12, 18, 24, 30].sample
        },
                   {
                     'name' => 'Rushing Touchdown Points',
                     'value' => [0, 6, 12, 18, 24, 30].sample
                   },
                   {
                     'name' => 'Field Goal Points',
                     'value' => [0, 3, 6, 9, 12, 15, 18, 21].sample
                   },
                   {
                     'name' => 'Extra Points',
                     'value' => [0, 1, 2, 3, 4, 5].sample
                   }]
      }, {
        'component' => 'barchart',
        'title' => 'Yards Gained per Play Type',
        'data' => [{
          'name' => 'Passing',
          'value' => rand(0..300)
        },
                   {
                     'name' => 'Rushing',
                     'value' => rand(0..200)
                   }]
      }],
      'Defense' => [{
        'component' => 'barchart',
        'title' => 'Yards Allowed per Play Type',
        'data' => [{
          'name' => 'Passing',
          'value' => rand(0..300)
        }, {
          'name' => 'Rushing',
          'value' => rand(0..300)
        }]
      }, {
        'component' => 'piechart',
        'title' => 'Successful Defensive Plays',
        'data' => [{
          'name' => 'Blitz',
          'value' => rand(0..30)
        },
                   {
                     'name' => 'Man Coverage',
                     'value' => rand(0..30)
                   },
                   {
                     'name' => 'Zonal Coverage',
                     'value' => rand(0..30)
                   }]
      }],
      'Players' => [{
        'component' => 'card',
        'data' => {
          'name' => 'Conner Weigman',
          'position' => 'Quarterback',
          'play_success_rate' => rand(0.6..1.0),
          'total_yards_gained' => 896
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Haynes King',
          'position' => 'Quarterback',
          'play_success_rate' => rand(0.5..1.0),
          'yards_gained' => 1220
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Max Johnson',
          'position' => 'Quarterback',
          'play_success_rate' => rand(0.4..0.8),
          'yards_gained' => 517
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Evan Stewart',
          'position' => 'Wide Receiver',
          'play_success_rate' => rand(0.7..1.0),
          'route_success_rate' => rand(0.6..1.0),
          'yards_gained' => 649
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Muhsin Muhammad III',
          'position' => 'Wide Receiver',
          'play_success_rate' => rand(0.6..1.0),
          'route_success_rate' => rand(0.6..1.0),
          'yards_gained' => 610
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Donovan Green',
          'position' => 'Wide Receiver',
          'play_success_rate' => rand(0.6..0.9),
          'route_success_rate' => rand(0.4..1.0),
          'yards_gained' => 233
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Max Wright',
          'position' => 'Wide Receiver',
          'play_success_rate' => rand(0.3..1.0),
          'route_success_rate' => rand(0.3..1.0),
          'yards_gained' => 129
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Devon Achane',
          'position' => 'Running Back',
          'play_success_rate' => rand(0.6..1.0),
          'route_success_rate' => rand(0.6..1.0),
          'yards_gained' => 1302
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Le\'Veon Moss',
          'position' => 'Running Back',
          'play_success_rate' => rand(0.6..1.0),
          'route_success_rate' => rand(0.6..1.0),
          'yards_gained' => 114
        }
      }, {
        'component' => 'card',
        'data' => {
          'name' => 'Ainias Smith',
          'position' => 'Running Back',
          'play_success_rate' => rand(0.4..0.8),
          'route_success_rate' => rand(0.4..0.8),
          'yards_gained' => 302
        }
      }]
    }

    frontend_report.to_json
  end

  # def generate_random_report()
  #     # fixed report for now
  #     report = {
  #         'Offense' => [{
  #             'component' => 'piechart',
  #             'title' => 'Point Distribution',
  #             'data' => [{
  #                 'name' => 'Passing Touchdown Points',
  #                 'value' => [0,6,12,18,24,30].sample
  #             },
  #             {
  #                 'name' => 'Rushing Touchdown Points',
  #                 'value' => [0,6,12,18,24,30].sample
  #             },
  #             {
  #                 'name' => 'Field Goal Points',
  #                 'value' => [0,3,6,9,12,15,18,21].sample
  #             },
  #             {
  #                 'name' => 'Extra Points',
  #                 'value' => [0,1,2,3,4,5].sample
  #             }],
  #         }, {
  #             'component' => 'barchart',
  #             'title' => 'Yards Gained per Play Type',
  #             'data' => [{
  #                 'name' => 'Passing',
  #                 'value' => rand(0..300)
  #             },
  #             {
  #                 'name' => 'Rushing',
  #                 'value' => rand(0..200)
  #             }]
  #         }],
  #         'Defense' => [{
  #             'component' => 'barchart',
  #             'title' => 'Yards Allowed per Play Type',
  #             'data' => [{
  #                 'name' => 'Passing',
  #                 'value' => rand(0..300)
  #             },{
  #                 'name' => 'Rushing',
  #                 'value' => rand(0..300)
  #             }]
  #         },{
  #             'component' => 'piechart',
  #             'title' => 'Successful Defensive Plays',
  #             'data' => [{
  #                 'name' => 'Blitz',
  #                 'value' => rand(0..30)
  #             },
  #             {
  #                 'name' => 'Man Coverage',
  #                 'value' => rand(0..30)
  #             },
  #             {
  #                 'name' => 'Zonal Coverage',
  #                 'value' => rand(0..30)
  #             }]
  #         }]
  #     }

  #     return report.to_json
  # end
end
