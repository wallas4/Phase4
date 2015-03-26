# CS 270 - Spring 2015 - QR Code Scavenger Hunt - Phase 4

In Phase 3, we rounded out the association between Events and Locations.
In this phase, we will turn our attention to the Participant resource.
We will do this in three stages: first, we will create the Participant
resource and seed the database appropriate.  Second, we will create the
association between Events and Participants.  Third, we will create the
association between Locations and Participants.

## Participant resource

For now, let us assume that a Participant is identified by an email
address.  This means we need to create a Participant scaffolding with
and email field as a string:

`rails g scaffold Participant email:string`

Next, we need to create some test Participants in the seeds.rb file.  We
do this by updating the seeds.rb file to include this code:

```
# create three Participants
3.times do |i|
    Participant.create(email: "participant#{i + 1}@email.com")
end
```

Of course, now that we have messed with the database slightly, we need
to re-initialize it.  The best way to do this is to first migrate the
existing Participant migration, then reset the database.

## Event-Participant association

As discussed in class, this association is a many-to-many association.
Thus, the association is going to mirror what we did for the
Event-Location association.

- Add the `has_and_belongs_to_many` method in the Event and Participant
  models
- Create the EventsParticipant migration
- Edit the migration in the same manner we did for EventsLocations
- Update the edit and show actions in the same manner as previously seen

The specifics of how to do so are left as an exercise. 

## Location-Participant association

This association is a little bit more tricky.  Recall, Locations and
Participants are not just arbitrarily related to one another: they are
related in a specific way.  That is, Locations and Participants are
related to one another *through* an Event.  Thus, the appropriate
association to utilize here is the Rails `has_many :through` association.

The `has_many :through` association operates in a similar fashion to
`has_and_belongs_to_many`.  Recall, the `has_and_belongs_to_many`
association essentially creates a third "join table," which pairs up ids
from each association resource.

The `has_many_through` association extends that concept by create a join
table that instead of pairing up ids, associates ids with three
resources:

```
event_id  |  location_id  | participant_id
------------------------------------------
    1             1               2
    1             2               2
    2             1               1
```

In this way, many Events can association many different Locations and
Participants together.

The other piece of the puzzle is to consider what form this join table
will take.  Rails accomplishes this by necessitating that this join
table be represented by a new resource.  For this project, we will call
this resource the Roster resource.  We can create the Roster resource
and specifiy the associations in one command:

`rails g scaffold Roster event:references location:references
participant:references`

That is step one.  Step two is to add the appropriate Rails association
methods in the appropriate classes:

- In the Event model: `has_one :roster`
- In the Location model: `has_many :rosters`
- In the Participant model: `has_many :rosters`

Step three is to create the `has_many :through` relationship in
Locations and Participants:

- In the Location model: `has_many :participants, :through => :rosters`
- In the Participant model: `has_many :locations, :through => :rosters`

Finally, step four is to add the `belongs_to` method in the newly
created Roster model:

```
belongs_to :event
belongs_to :location
belongs_to :participant
```

Once you have accomplished all of this, remember to migrate the
database.
